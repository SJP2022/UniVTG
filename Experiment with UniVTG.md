# Experiment with UniVTG

Notice: We use slurm for job running, you may need to slightly modify the code to adapt your environment if you do not use slurm system.

## Environment

```shell
git clone https://github.com/SJP2022/UniVTG.git
cd UniVTG

conda create --name univtg python=3.10
conda activate univtg
pip install -r requirements.txt
```

## Dataset

1. Download the video features for downstream dataset.
   
   ```shell
   bash my_scripts/dataset.sh
   ```
   
   | Dataset                                                      | Video (Slowfast R50)                                                                            | Video (CLIP B/32)                                                                               |
   | ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
   | [ActivityNet](http://activity-net.org/) with raw annotations | [4.5 GB](https://drive.google.com/file/d/1LySSKToHUF-4NI_ozr0GdRbh3EFefaZG/view?usp=drive_link) | [1.0 GB](https://drive.google.com/file/d/1M7MSAvXVrhGqJVs-PJe-XVqux5fRVgw9/view?usp=drive_link) |
   | ActivityNet with blip2+densecap annotations                  | 👆                                                                                              | 👆                                                                                              |
   | ActivityNet with llamavid annotations                        | 👆                                                                                              | 👆                                                                                              |

2. Extract the text features for downstream dataset.
   
   ```shell
   bash my_scripts/txt_extractor.sh
   ```

3. Organize the data / features in the following structure. **Check it!** 
   
   ```bash
   univtg
   ├── eval
   ├── data
   │   ├── anet
   │   │   ├── metadata
   │   │   ├── txt_clip
   │   │   ├── vid_clip
   │   │   └── vid_slowfast
   │   ├── anetdv_new
   │   │   ├── metadata
   │   │   ├── txt_clip
   │   │   ├── vid_clip
   │   │   └── vid_slowfast
   │   └── anetlv_new
   │       ├── metadata
   │       ├── txt_clip
   │       ├── vid_clip
   │       └── vid_slowfast
   ├── main
   ├── model
   ├── utils
   ├── README.md
   └── ···
   ```

## Model

Download the pt&ft model ckpt.

```shell
bash my_scripts/checkpoint.sh
```

| Video Enc.               | Text Enc. | Pretraining | Fine-tuning                                          | Checkpoints                                                                                          |
| ------------------------ | --------- | ----------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Slowfast R50 + CLIP-B/32 | CLIP-B/32 | 4M          | -                                                    | [Google Drive](https://drive.google.com/drive/folders/1eWpuTTBRaMoV4UsEteQHAf5t4dU7uwrl?usp=sharing) |
| Slowfast R50 + CLIP-B/32 | CLIP-B/32 | 4M          | QVHL + Charades + NLQ + TACoS + ActivityNet + DiDeMo | [Google Drive](https://drive.google.com/drive/folders/1pzHDW82Eja7OeH01AnkWNFsXH8JANnZX?usp=sharing) |

## Experiment

1. train on our data&test on our data
   
   - train
     
     ```shell
     bash my_scripts/anetdv_ft_our_data.sh
     bash my_scripts/anetlv_ft_our_data.sh
     ```
   
   - test, **remember to indicate `resume` to evaluate selected checkpoint** 
     
     ```shell
     bash my_scripts/anetdv_ft_our_data_inference.sh
     bash my_scripts/anetdv_ft_our_data_inference.sh
     ```

2. train on our data&test on raw dataset
   
   - train
     
     ```shell
     bash my_scripts/anet_ft_raw_data.sh
     bash my_scripts/anetdv_ft_raw_data.sh
     bash my_scripts/anetlv_ft_our_data.sh
     ```
   
   - test, **remember to indicate `resume` to evaluate selected checkpoint** 
     
     ```shell
     bash my_scripts/anet_ft_raw_data_inference.sh
     bash my_scripts/anetdv_ft_raw_data_inference.sh
     bash my_scripts/anetdv_ft_raw_data_inference.sh
     ```

3. train on mixed data&test on raw dataset
   
   - train
     
     ```shell
     bash my_scripts/anetdv_ft_mix_data.sh
     bash my_scripts/anetlv_ft_mix_data.sh
     ```
   
   - test, **remember to indicate `resume` to evaluate selected checkpoint** 
     
     ```shell
     bash my_scripts/anetdv_ft_mix_data_inference.sh
     bash my_scripts/anetdv_ft_mix_data_inference.sh
     ```
