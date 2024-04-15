#!/bin/bash
#SBATCH -o out/preprocess_out/txt_extractor.out  
#SBATCH --partition=fvl       # 作业提交的指定分区;
#SBATCH --qos=high            # 指定作业的QOS;
#SBATCH -J txt_extractor      # 作业在调度系统中的作业名;
#SBATCH --nodes=1             # 申请节点数为1;
#SBATCH --gres=gpu:1          # 申请GPU数量为1;
#SBATCH --mem=24G             # 申请内存为24G;
#SBATCH --time=48:00:00       # 作业运行的最长时间为2天;
source activate univtg        # 激活的conda环境为univtg;

export PYTHONPATH=.:$PYTHONPATH

echo "Extracting anet train txt features"
python run_on_video/text_extractor.py --dataset anet --split train --out txt_clip
echo "Extracting anet val_1 txt features"
python run_on_video/text_extractor.py --dataset anet --split val_1 --out txt_clip
echo "Extracting anet val_2 txt features"
python run_on_video/text_extractor.py --dataset anet --split val_2 --out txt_clip_test

echo "Extracting anetdv_new train txt features"
python run_on_video/text_extractor.py --dataset anetdv_new --split train --out txt_clip
echo "Extracting anetdv_new val txt features"
python run_on_video/text_extractor.py --dataset anetdv_new --split val --out txt_clip

echo "Extracting anetlv_new train txt features"
python run_on_video/text_extractor.py --dataset anetlv_new --split train --out txt_clip
echo "Extracting anetlv_new val txt features"
python run_on_video/text_extractor.py --dataset anetlv_new --split val --out txt_clip