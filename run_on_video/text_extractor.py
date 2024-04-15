import argparse
import pdb
import sys
import json
import torch
import numpy as np
from run_on_video.data_utils import ClipFeatureExtractor
import torch.nn.functional as F
import tqdm
import os

parser = argparse.ArgumentParser()
parser.add_argument('--dataset', type=str, required=True)
parser.add_argument('--split', type=str, required=True)
parser.add_argument('--out', type=str, required=True)
args = parser.parse_args()

dataset = args.dataset
split = args.split
out = args.out
query_list = []
qid_list = []

txt_path = f"data/{dataset}/metadata/{split}.jsonl"
save_dir = f"data/{dataset}/{out}"

#with open(f"data/{dataset}/metadata/{dataset}_{split}.jsonl", 'r') as f:
with open(txt_path, 'r') as f:
    while True:
        line = f.readline()
        if not line:
            break
        js = json.loads(line)
        query_list.append(js['query'])
        qid_list.append(str(js['qid']))

# clip
feature_extractor = ClipFeatureExtractor(
    framerate=1 / 2, size=224, centercrop=True,
    model_name_or_path="ViT-B/32", device='cuda'
)

# pdb.set_trace()
query_feats = feature_extractor.encode_text(query_list)

for i in tqdm.tqdm(range(len(query_feats))):
        np.savez(save_dir + '/' + qid_list[i],  last_hidden_state=query_feats[i].cpu().numpy())
