TORCH_CUDNN_V8_API_ENABLED=1 TFDS_PREFETCH_SIZE=8192 torchrun --nproc_per_node 8 -m training.main \
    --save-frequency 1 \
    --save-most-recent \
    --zeroshot-frequency 1 \
    --train-data '/path/to/laion-400m' \
    --dataset-type tfrecord \
    --lr "1.024e-3" \
    --beta1 0.9 \
    --beta2 0.95 \
    --warmup 1563 \
    --wd 0.2 \
    --batch-size 4096 \
    --aug-cfg scale='(0.4, 1.0)' color_jitter='(0.32, 0.32, 0.32, 0.08)' color_jitter_prob=0.8 gray_scale_prob=0.2 \
    --pos-embed 'sin_cos_2d' \
    --epochs=6 \
    --workers=6 \
    --model ViT-L-16-CL16-Syntax-GAP \
    --precision 'amp_bf16' \
    --ddp-static-graph \
    --local-loss \
    --gather-with-grad \
    --force-image-size 64 \
    --to-float-on-device \
    --grad-checkpointing \
    --log-every-n-steps 64 --zeroshot-steps 3052 --val-steps 3052 \
    --seed 0 \
    --logs ./logs/ \
    --imagenet-val '/path/to/imagenet/val'



