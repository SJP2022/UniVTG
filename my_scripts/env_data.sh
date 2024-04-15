#!/bin/bash
#SBATCH --partition=fvl       # 作业提交的指定分区;
#SBATCH --qos=high            # 指定作业的QOS;
#SBATCH -J dataset            # 作业在调度系统中的作业名;
#SBATCH --nodes=1             # 申请节点数为1;
#SBATCH --gres=gpu:0          # 申请GPU数量为1;
#SBATCH --mem=24G             # 申请内存为24G;
#SBATCH --time=48:00:00       # 作业运行的最长时间为2天;

echo "Building environment"
git clone https://github.com/SJP2022/UniVTG.git
cd UniVTG

source ~/.bashrc
source ~/miniconda3/etc/profile.d/conda.sh
conda create --name univtg python=3.10
conda activate univtg
pip install -r requirements.txt

echo "Mkdir"
# for slurm out log
mkdir out/preprocess_out out/anet_ft_out out/anetdv_ft_out out/anetlv_ft_out
# for ckpt
mkdir results/slowfast_ft results/slowfast_pt
# for text features
mkdir data/anet/txt_clip data/anet/txt_clip_test data/anetdv/txt_clip data/anetlv/txt_clip

export PYTHONPATH=.:$PYTHONPATH

echo "Downloading vid_slowfast features"
gdown https://drive.google.com/file/d/1LySSKToHUF-4NI_ozr0GdRbh3EFefaZG/view?usp=sharing --fuzzy -c
echo "Downloading vid_clip features"
gdown https://drive.google.com/file/d/1M7MSAvXVrhGqJVs-PJe-XVqux5fRVgw9/view?usp=sharing --fuzzy -c
#echo "Downloading raw txt_clip features"
#gdown https://drive.google.com/file/d/1M8MOUOb-Z14V9DdAb6ABfYpULdU8fZ27/view?usp=sharing --fuzzy -c
echo "Unpacking vid_slowfast"
tar -xvf vid_slowfast.tar
echo "Unpacking vid_clip"
tar -xvf vid_clip.tar
#echo "Unpacking txt_clip"
#tar -xvf txt_clip.tar
mv data/home/qinghonglin/univtg/data/anet/* .
rm -r data/home

echo "Changing path and soft linking"
#mv txt_clip data/anet
my_array=("anet" "anetdv_new" "anetlv_new")
for file in "${my_array[@]}"
do
    ln -s vid_slowfast data/$file/vid_slowfast
    ln -s vid_clip data/$file/vid_clip
    #echo $file
done

echo "Downloading pt ckpt"
gdown https://drive.google.com/drive/folders/1eWpuTTBRaMoV4UsEteQHAf5t4dU7uwrl -O results/slowfast_pt --folder
echo "Downloading ft ckpt"
gdown https://drive.google.com/drive/folders/1pzHDW82Eja7OeH01AnkWNFsXH8JANnZX -O results/slowfast_ft --folder