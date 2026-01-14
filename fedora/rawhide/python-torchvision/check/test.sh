#!/bin/sh

rocm_agent_enumerator

cd ~/rpmbuild/BUILD/python-torchvision-*/vision-*/
cd test

# complaining about nvJPEG
pytest test_image.py

bash
