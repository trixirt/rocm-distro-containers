#!/bin/sh

rocm_agent_enumerator

cd ~/rpmbuild/BUILD/python-torch-*/pytorch-*/
cd test

# Too many failures complaining about not running on mi300
# pytest test_matmul_cuda.py
cd nn
pytest

bash
