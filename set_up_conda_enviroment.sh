#!/usr/bin/env bash
set -euo pipefail

#RUN: chmod +x ./settingUp.sh && sudo ./settingUp.sh
#tested on CUDA Version: 11.4   Driver Version: 470.182.03

#conda remove -n CONDA_ENV_NAME --all -y

CONDA_ENV_NAME="DL_env"
echo "[INFO] Creating enviroment: " + $CONDA_ENV_NAME

source ~/anaconda3/bin/activate
conda info --envs
conda create -y --name $CONDA_ENV_NAME python=3.10
conda activate $CONDA_ENV_NAME

echo "[INFO] Install Pytorch-GPU"

conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y

python -c """
import torch
if torch.cuda.is_available():
    print('CUDA is available')
else:
    print('CUDA isnt available')
"""

#Install NeMo enviroment

echo "[INFO] Install Nemo packages "
apt-get update && apt-get install -y libsndfile1 ffmpeg
pip install Cython
pip install nemo_toolkit['all']

#For RNNT
#echo "[INFO] Install RNNT Numba packages "
#conda remove numba
#pip uninstall numba
#conda install -c conda-forge numba

echo "[INFO] Installing Compiler tools"
sudo apt -y -qqq install build-essential cmake unzip pkg-config

echo "[INFO] Installing Multiple terminals in the same windows"
sudo apt -y -qqq install screen

echo "[INFO] Installing X Windows Libraries and OpenGL libraries"
sudo apt -y -qqq install libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev

echo "[INFO] Installing Image and video I/O libraries"
sudo apt -y -qqq install libjpeg-dev libpng-dev libtiff-dev
sudo apt -y -qqq install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt -y -qqq install libxvidcore-dev libx264-dev

echo "[INFO] Installing Optimization libraries"
sudo apt -y -qqq install libopenblas-dev libatlas-base-dev liblapack-dev gfortran

echo "[INFO] Installing HDF5 for large datasets"
sudo apt -y -qqq install libhdf5-serial-dev

echo "[INFO] Installing Python 3 development libraries"
sudo apt -y -qqq install python3-dev python3-tk python-imaging-tk
sudo apt -y -qqq install libgtk-3-dev

echo "[INFO] Installing NumPy"
pip -qq install numpy

#echo "[INFO] Installing TensorFlow"
#pip -qq install tensorflow==2.2.0

# Installing TensorFlow 2.0 associated packages

echo "[INFO] Installing image processing libraries"
pip -qq install opencv-contrib-python
pip -qq install scikit-image
pip -qq install pillow
pip -qq install imutils

echo "[INFO] Installing machine learning libraries and support libraries"
pip -qq install scikit-learn
pip -qq install matplotlib
pip -qq install progressbar2
pip -qq install beautifulsoup4
pip -qq install pandas

echo "[INFO] Done"
