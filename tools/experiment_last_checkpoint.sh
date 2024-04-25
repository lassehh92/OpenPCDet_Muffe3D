#!/bin/bash

# Define a list of epoch values and batch sizes to test
EPOCH_VALUES=(5 10 15)
BATCH_SIZES=(2 4)

# Base directory where checkpoints are saved
BASE_CKPT_DIR="/home/lasse/Git/OpenPCDet_Muffe3D/output/custom_models/pointrcnn_base"

# Loop through each batch size
for BATCH_SIZE in "${BATCH_SIZES[@]}"
do
    # Try to find the last checkpoint for this batch size
    LAST_EPOCH=0
    for EPOCH in "${EPOCH_VALUES[@]}"
    do
        CKPT_FILE="${BASE_CKPT_DIR}/exp_${EPOCH}_epochs_${BATCH_SIZE}_batch/ckpt/checkpoint_epoch_${EPOCH}.pth"
        #"output/custom_models/pointrcnn_base/exp_10_epochs_2_batch/ckpt/checkpoint_epoch_1.pth"
        if [ -f "$CKPT_FILE" ]; then
            LAST_EPOCH=$EPOCH
        fi
    done

    # Start training from the epoch following the last found checkpoint
    START_EPOCH=$((LAST_EPOCH + 1))

    # Loop through remaining epoch values starting from the next epoch after the last checkpoint
    for (( EPOCH=START_EPOCH; EPOCH <= ${EPOCH_VALUES[-1]}; EPOCH++ ))
    do
        echo "Starting training for ${EPOCH} epochs with batch size ${BATCH_SIZE} from checkpoint..."
        python train.py --cfg_file cfgs/custom_models/pointrcnn_base.yaml --epochs $EPOCH --batch_size $BATCH_SIZE --extra_tag "exp_${EPOCH}_epochs_${BATCH_SIZE}_batch" --ckpt "${BASE_CKPT_DIR}/exp_${EPOCH}_epochs_${BATCH_SIZE}_batch/ckpt/checkpoint_epoch_${EPOCH}.pth"
        echo "Training for ${EPOCH} epochs with batch size ${BATCH_SIZE} completed."
    done
done

echo "All experiments completed."
