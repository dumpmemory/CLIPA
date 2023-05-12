TORCH_CUDNN_V8_API_ENABLED=1 TFDS_PREFETCH_SIZE=8192 torchrun --nproc_per_node 8 -m training.main \
    --save-frequency 1 \
    --save-most-recent \
    --zeroshot-frequency 1 \
    --train-data '/path/to/laion-400m' \
    --dataset-type tfrecord \
    --lr "2.56e-5" \
    --beta1 0.9 \
    --beta2 0.95 \
    --warmup 3072 \
    --wd 0.2 \
    --batch-size 1024 \
    --aug-cfg scale='(0.4, 1.0)' \
    --pos-embed 'learnable' \
    --epochs=1 \
    --train-num-samples 131072000 \
    --workers=6 \
    --model ViT-B-16-CL16 \
    --pretrained '/path/to/ckpt' \
    --precision 'amp_bf16' \
    --ddp-static-graph \
    --local-loss \
    --gather-with-grad \
    --to-float-on-device \
    --grad-checkpointing \
    --log-every-n-steps 256 \
    --seed 0 \
    --logs ./logs/ \
    --imagenet-val '/path/to/imagenet/val'
