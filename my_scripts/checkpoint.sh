#!/bin/bash
#SBATCH -o out/preprocess_out/checkpoint.out  
#SBATCH --partition=fvl       # 作业提交的指定分区;
#SBATCH --qos=high            # 指定作业的QOS;
#SBATCH -J checkpoint         # 作业在调度系统中的作业名;
#SBATCH --nodes=1             # 申请节点数为1;
#SBATCH --gres=gpu:0          # 申请GPU数量为1;
#SBATCH --mem=24G             # 申请内存为24G;
#SBATCH --time=48:00:00       # 作业运行的最长时间为2天;
source activate univtg        # 激活的conda环境为univtg;

export PYTHONPATH=.:$PYTHONPATH

echo "Downloading pt ckpt"
gdown https://drive.google.com/drive/folders/1eWpuTTBRaMoV4UsEteQHAf5t4dU7uwrl -O results/slowfast_pt --folder
echo "Downloading ft ckpt"
gdown https://drive.google.com/drive/folders/1pzHDW82Eja7OeH01AnkWNFsXH8JANnZX -O results/slowfast_ft --folder