How to use containers to do some builds

---
Cheat sheet
Build:
docker build -t <os> .

Run:
docker run --volume <host-path>:<container-path> -it --rm -p 8080:8080 --cpus=<num> <os>

--volume is option
-p is optional
--cpus is optional but useful.

---
Setup the host
Some links for different distros

Fedora
https://developer.fedoraproject.org/tools/docker/docker-installation.html

OpenSUSE
https://www.suse.com/c/rancher_blog/introduction-to-using-docker/

Ubuntu
https://docs.docker.com/engine/install/ubuntu/
# apt-get install docker.io

---
Trouble shooting

Using /dev/kfd
[root@3ff4ca99a474 test]# rocminfo
ROCk module is loaded
Unable to open /dev/kfd read-write: No such file or directory
Failed to get user name to check for video group membership

Likely need to pass the --device /dev/kfd --device /dev/dri

---
Starting distro images

SUSE
https://en.opensuse.org/Docker
https://hub.docker.com/r/opensuse/tumbleweed

cs10
docker pull quay.io/centos/centos:stream10

---
Examples of uses

1. Test rocfft on OpenSUSE

Go to the OpenSUSE check dir for librocfft0

> cd opensuse/tumbleweed/librocfft0/check

Build the container as root

# docker build -t test .

On a machine with a AMD GPU, run the container

# docker run --device /dev/kfd --device /dev/dri -it --rm test

2. Creating a new test

Use the source! Here is how the librocfft0 check docker comparse to the
build docker.

> cd opensuse/tumbleweed/librocfft0/

$ diff -u Dockerfile check/Dockerfile
--- Dockerfile	2025-06-04 13:47:33.596666381 -0700
+++ check/Dockerfile	2025-06-04 14:28:38.120159800 -0700
@@ -11,6 +11,17 @@
 RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
 RUN zypper -n si librocfft0
 RUN zypper -n si -d librocfft0
-RUN rpmbuild -ba ~/rpmbuild/SPECS/*.spec
 
-CMD ["bash"]
\ No newline at end of file
+RUN zypper -n install \
+ rocrand-devel \
+ fftw-devel \
+ boost-devel \
+ hipcc-libomp-devel \
+ hiprand-devel \
+ gtest
+
+RUN rpmbuild --with test -ba ~/rpmbuild/SPECS/*.spec
+
+RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*
+
+CMD ["rocfft-test"]
\ No newline at end of file

Same diff, now annotated

$ diff -u Dockerfile check/Dockerfile
--- Dockerfile	2025-06-04 13:47:33.596666381 -0700
+++ check/Dockerfile	2025-06-04 14:28:38.120159800 -0700
@@ -11,6 +11,17 @@
 RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
 RUN zypper -n si librocfft0
 RUN zypper -n si -d librocfft0
-RUN rpmbuild -ba ~/rpmbuild/SPECS/*.spec
+RUN rpmbuild --with test -ba ~/rpmbuild/SPECS/*.spec

The rpm is built with an option '--with test', in the specfile this is this
section

%bcond_with test
%if %{with test}
# Disable rpatch checks for a local build
%global __brp_check_rpaths %{nil}
%global build_test ON
%else
%global build_test OFF
%endif

Look for instances of %if %{with test}, in the specfile.

\ No newline at end of file
+RUN zypper -n install \
+ rocrand-devel \
+ fftw-devel \
+ boost-devel \
+ hipcc-libomp-devel \
+ hiprand-devel \
+ gtest
+

Building for testing requires other dependencies to be installed.
This is the part that will change dependent on the package.  You can find
the list by looking in the specfile, like for rocfft.spec

%if %{with test}
BuildRequires:  rocrand-devel
BuildRequires:  fftw-devel
BuildRequires:  boost-devel
BuildRequires:  hipcc-libomp-devel
BuildRequires:  hiprand-devel

%if 0%{?suse_version}
BuildRequires:  gtest
%else
BuildRequires:  gtest-devel
%endif

Note, because this is a suse test, we install gtest over gtest-devel, like
we do for fedora or rhel.

+RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

This installs all the rpms that were just built, including the test rpms.

-CMD ["bash"]
+CMD ["rocfft-test"]

Changing the run command from bash to the just installed rocfft-test

Apply this to creating a test for opensuse rocblas.

$ cd opensuse/tumbleweed/librocblas4
$ mkdir check
$ cp Dockerfile check/

Review the rocblas.spec file for test dependencies. From these lines in the
spec file

%if %{with test}

BuildRequires:  blas-devel
BuildRequires:  libomp-devel
BuildRequires:  python3dist(pyyaml)
BuildRequires:  rocminfo
BuildRequires:  rocm-smi-devel
BuildRequires:  roctracer-devel

%if 0%{?suse_version}
BuildRequires:  cblas-devel
BuildRequires:  gcc-fortran
BuildRequires:  gtest
%else
BuildRequires:  gtest-devel
%endif

%endif

Add this line to install the test dependencies

RUN zypper -n install \
 blas-devel \
 libomp-devel \
 python311-PyYAML \
 python312-PyYAML \
 python313-PyYAML \
 rocminfo \
 rocm-smi-devel \
 roctracer-devel \
 cblas-devel \
 gcc-fortran \
 gtest \

The tricky part is translating this

BuildRequires:  python3dist(pyyaml)

Do this
> zypper search pyyaml

S  | Name                     | Summary                                                               | Type
---+--------------------------+-----------------------------------------------------------------------+--------
i  | python311-PyYAML         | YAML parser and emitter for Python                                    | package
   | python311-pyyaml_env_tag | A custom YAML tag for referencing environment variables in YAML files | package
   | python311-types-PyYAML   | Typing stubs for PyYAML                                               | package
i  | python312-PyYAML         | YAML parser and emitter for Python                                    | package
   | python312-pyyaml_env_tag | A custom YAML tag for referencing environment variables in YAML files | package
   | python312-types-PyYAML   | Typing stubs for PyYAML                                               | package
i  | python313-PyYAML         | YAML parser and emitter for Python                                    | package
   | python313-pyyaml_env_tag | A custom YAML tag for referencing environment variables in YAML files | package
   | python313-types-PyYAML   | Typing stubs for PyYAML                                               | package

To find the likely packages to install.

Now build the tests, change

RUN rpmbuild -ba ~/rpmbuild/SPECS/*.spec

to

RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/*.spec

Then install the rpms that where just built, add this line

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

Finally, change the CMD at the bottom to run the tests

CMD ["rocblas-test"]

3. Picking which GPU to test

-e HIP_VISIBLE_DEVICES=0

When the system has multiple GPU's, you may face a problem like

Query device success: there are 2 devices
-------------------------------------------------------------------------------
Device ID 0 : AMD Radeon Pro W7900 gfx1100
with 48.3 GB memory, max. SCLK 1760 MHz, max. MCLK 1124 MHz, memoryBusWidth 48 Bytes, compute capability 11.0
maxGridDimX 2147483647, sharedMemPerBlock 65.5 KB, maxThreadsPerBlock 1024, warpSize 32
-------------------------------------------------------------------------------
Device ID 1 : AMD Radeon Graphics gfx1036
with 67.1 GB memory, max. SCLK 2200 MHz, max. MCLK 1800 MHz, memoryBusWidth 16 Bytes, compute capability 10.3
maxGridDimX 2147483647, sharedMemPerBlock 65.5 KB, maxThreadsPerBlock 1024, warpSize 32
-------------------------------------------------------------------------------
info: parsing of test data may take a couple minutes before any test output appears...

Note: Google Test filter = -:*stress*
[==========] Running 1254647 tests from 210 test suites.
[----------] Global test environment set-up.
[----------] 1 test from _/multiheaded

rocBLAS error: Cannot read /lib64/rocblas/library/TensileLibrary.yaml: No such file or directory for GPU arch : gfx1036

Read the HIP docs ex/
https://rocm.docs.amd.com/projects/HIP/en/docs-6.0.0/how_to_guides/debugging.html

    Making Device visible

    For system with multiple devices, it’s possible to make only certain
    device(s) visible to HIP via setting environment variable,
    HIP_VISIBLE_DEVICES(or CUDA_VISIBLE_DEVICES on Nvidia platform), only
    devices whose index is present in the sequence are visible to HIP.

    For example,

    HIP_VISIBLE_DEVICES=0,1

Pass -e HIP_VISIBLE_DEVICES=<num> in the docker run

4. Rebuild a just-built container

Docker caches most of the steps, it is necessary to clean the cache and
remove the image to rebuild the image.

$ docker builder prune -a
$ docker rmi b

5. Where are the SUSE ROCm packages ?

The SUSE packages are produced by OBS, this is the project link
https://build.opensuse.org/project/show/science:GPU:ROCm

To find the repo location for the binaries, look at the 'Build Results'
for the SUSE version closest to what you are building or testing.

ex/ 15.6, click 15.6 and you are taken to this page
https://build.opensuse.org/project/repository_state/science:GPU:ROCm/15.6

Look for the link 'Go to download repository'
https://download.opensuse.org/repositories/science:/GPU:/ROCm/15.6/

It is necessary to add this repo so the ROCm packages can be found by
zypper.  An example of the use is

https://github.com/trixirt/rocm-distro-containers/blob/main/suse/15.6/amdsmi/check/Dockerfile

This line shows how to add the repo.
RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/15.6/ rocm
For other versions of SUSE, replace https://* with the specific version that is required.

