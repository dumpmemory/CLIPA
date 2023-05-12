#python3 -c "import wandb; print(wandb.util.generate_id())"

# control log_steps so that however batch size changes, it logs every 2 * 1024 * 1024 samples
# full image finetune for 4000 steps
# use resize_pos_embed(state_dict, model) in factory.py
# finetuned on gpu, so grad checkpoint, amp_bf16 and static graph is enabled

TORCH_CUDNN_V8_API_ENABLED=1 TFDS_PREFETCH_SIZE=8192 torchrun --nproc_per_node 8 -m training.main \
    --save-frequency 1 \
    --save-most-recent \
    --zeroshot-frequency 1 \
    --train-data '/path/to/laion-400m' \
    --dataset-type tfrecord \
    --lr "2.24e-5" \
    --beta1 0.9 \
    --beta2 0.95 \
    --warmup 3571 \
    --wd 0.2 \
    --batch-size 896 \
    --aug-cfg scale='(0.4, 1.0)' color_jitter='(0.32, 0.32, 0.32, 0.08)' color_jitter_prob=0.8 gray_scale_prob=0.2 \
    --pos-embed 'learnable' \
    --epochs=1 \
    --train-num-samples 131072000 \
    --workers=6 \
    --model ViT-L-16-CL16-GAP \
    --pretrained '/path/to/ckpt' \
    --precision 'amp_bf16' \
    --ddp-static-graph \
    --local-loss \
    --gather-with-grad \
    --to-float-on-device \
    --grad-checkpointing \
    --log-every-n-steps 293 --zeroshot-steps 2286 --val-steps 2286 \
    --seed 0 \
    --logs ./logs/ \
    --imagenet-val '/path/to/imagenet/val'