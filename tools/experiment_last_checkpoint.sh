#!/bin/bash

# Initial epoch value
INITIAL_EPOCH=20
# Increment value for each loop
EPOCH_INCREMENT=20
# Maximum number of loops or maximum epoch to be reached (optional, adjust as needed)
MAX_EPOCH=200
# Set a single batch size
BATCH_SIZE=1
# Set a single batch size
MODEL_NAME="pointrcnn_base_radii_region"
# Define the base directory for checkpoints
BASE_CKPT_DIR="/home/lasse/Git/OpenPCDet_Muffe3D/output/custom_models/${MODEL_NAME}"

# Start from the initial epoch and increase by the increment until reaching or exceeding the max epoch
for ((EPOCH=$INITIAL_EPOCH; EPOCH<=$MAX_EPOCH; EPOCH+=$EPOCH_INCREMENT))
do
    # Calculate previous epoch for checkpoint reference, assume initial has no previous checkpoint
    PREV_EPOCH=$((EPOCH - EPOCH_INCREMENT))
    # Determine the checkpoint file to use
    if [ $EPOCH -eq $INITIAL_EPOCH ]
    then
        # For the initial epoch, no checkpoint is used
        CKPT_FILE=""
    else
        # For subsequent epochs, use checkpoint from the previous run
        CKPT_FILE="--ckpt ${BASE_CKPT_DIR}/exp_${PREV_EPOCH}_epochs_${BATCH_SIZE}_batch/ckpt/checkpoint_epoch_${PREV_EPOCH}.pth"
    fi

    echo "Starting training ${MODEL_NAME} for ${EPOCH} epochs with batch size ${BATCH_SIZE} from checkpoint..."
    python train.py --cfg_file cfgs/custom_models/${MODEL_NAME}.yaml --epochs $EPOCH --batch_size $BATCH_SIZE --extra_tag "exp_${EPOCH}_epochs_${BATCH_SIZE}_batch" $CKPT_FILE
    echo "Training for ${EPOCH} epochs with batch size ${BATCH_SIZE} completed."
done

echo "All experiments completed."
