#!/usr/bin/env python3
"""
Script to find and run smoke tests from tar files in smoke subdirectories.
The tag for each Docker image is the basename of the tar file.
"""

import os
import glob
import sys
from pathlib import Path

def find_tar_files():
    """Find all tar files in smoke directories and return structured data"""
    tar_files = []
    
    # Find all smoke directories
    smoke_dirs = list(Path(".").glob("**/smoke"))
    
    print("Searching for tar files in smoke directories...")
    print(f"Found {len(smoke_dirs)} smoke directories")
    
    for smoke_dir in smoke_dirs:
        # Look for tar files in each smoke directory
        tar_pattern = str(smoke_dir / "*.tar")
        found_tars = glob.glob(tar_pattern)
        
        if found_tars:
            print(f"\nFound tar files in {smoke_dir}:")
            for tar_file in found_tars:
                # Get file size
                try:
                    size = os.path.getsize(tar_file)
                    size_mb = size / (1024 * 1024)
                    filename = os.path.basename(tar_file)
                    dirname = os.path.dirname(tar_file)
                    print(f"  {filename} ({size_mb:.2f} MB)")
                    
                    # The tag for the docker image is the basename of the tar file
                    tag = filename.replace(".tar", "")
                    print(f"    Docker tag: {tag}")
                    
                    # Add to structured data
                    tar_files.append({
                        'filename': filename,
                        'path': tar_file,
                        'dirname': dirname,
                        'size_bytes': size,
                        'size_mb': round(size_mb, 2),
                        'docker_tag': tag
                    })
                except OSError:
                    print(f"  {tar_file} (size unknown)")
                    dirname = os.path.dirname(tar_file)
                    tar_files.append({
                        'filename': os.path.basename(tar_file),
                        'path': tar_file,
                        'dirname': dirname,
                        'size_bytes': None,
                        'size_mb': None,
                        'docker_tag': os.path.basename(tar_file).replace(".tar", "")
                    })
    
    return tar_files

def main():
    """Main function"""
    import datetime
    print("ROCM Smoke Test Runner")
    print("=" * 40)
    print(f"Run date: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Print system information
    import subprocess
    try:
        result = subprocess.run(['uname', '-a'], capture_output=True, text=True, check=True)
        print(f"System: {result.stdout.strip()}")
    except subprocess.CalledProcessError:
        print("System: Unable to determine system information")
    except FileNotFoundError:
        print("System: uname command not found")
    
    # Print ROCm information
    try:
        result = subprocess.run(['rocminfo'], capture_output=True, text=True, check=True)
        print("ROCm Information:")
        print(result.stdout)
    except subprocess.CalledProcessError:
        print("ROCm Information: Unable to retrieve rocminfo")
    except FileNotFoundError:
        print("ROCm Information: rocminfo command not found")
    
    # Ensure we run from top-level directory
    script_dir = Path(__file__).parent.absolute()
    repo_root = script_dir.parent.parent
    
    os.chdir(repo_root)
    
    tar_files = find_tar_files()
    
    print(f"\nTotal tar files found: {len(tar_files)}")
    
    if not tar_files:
        print("No tar files found in smoke directories.")
        return 1
    
    # Print details for each tar file
    print("\nDetailed information:")
    print("-" * 50)
    for i, tar_file in enumerate(tar_files, 1):
        print(f"{i}. Filename: {tar_file['filename']}")
        print(f"   Path:     {tar_file['path']}")
        print(f"   Dir:      {tar_file['dirname']}")
        print(f"   Size:     {tar_file['size_mb']} MB")
        print(f"   Tag:      {tar_file['docker_tag']}")
        print()
        
        # Run the script with the tar file
        import subprocess
        try:
            print(f"Running scripts/run -f {tar_file['path']}")
            # Use the script directory to construct the path to run script
            script_dir = os.path.dirname(os.path.abspath(__file__))
            run_script_path = os.path.join(script_dir, "run")
            result = subprocess.run([run_script_path, "-f", tar_file['path']], 
                                  capture_output=True, text=True, check=True)
            print("Output:", result.stdout)
            if result.stderr:
                print("Errors:", result.stderr)
        except subprocess.CalledProcessError as e:
            print(f"Error running scripts/run -f {tar_file['path']}: {e}")
        except FileNotFoundError:
            print("Error: scripts/run not found")
    
    # Save results to file
    with open("smoke_tars.txt", "w") as f:
        for tar_file in tar_files:
            f.write(f"{tar_file['path']}\n")
    
    print("Results saved to smoke_tars.txt")
    return 0

if __name__ == "__main__":
    sys.exit(main())
