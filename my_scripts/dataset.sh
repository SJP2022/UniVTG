#!/bin/bash
#SBATCH -o out/preprocess_out/dataset.out  
#SBATCH --partition=fvl       # 作业提交的指定分区;
#SBATCH --qos=high            # 指定作业的QOS;
#SBATCH -J dataset            # 作业在调度系统中的作业名;
#SBATCH --nodes=1             # 申请节点数为1;
#SBATCH --gres=gpu:0          # 申请GPU数量为1;
#SBATCH --mem=24G             # 申请内存为24G;
#SBATCH --time=48:00:00       # 作业运行的最长时间为2天;
source activate univtg        # 激活的conda环境为univtg;

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