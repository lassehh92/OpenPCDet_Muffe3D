#!/bin/bash

# Define a list of epoch values, batch sizes, and learning rates to test
EPOCH_VALUES=(50)
BATCH_SIZES=(1 2 4)
LEARNING_RATES=(0.01 0.005 0.001)

# Loop through each batch size
for BATCH_SIZE in "${BATCH_SIZES[@]}"
do
    # Then loop through each epoch value
    for EPOCH in "${EPOCH_VALUES[@]}"
    do
        # Finally, loop through each learning rate
        for LR in "${LEARNING_RATES[@]}"
        do
            echo "Starting training for ${EPOCH} epochs with batch size ${BATCH_SIZE} and learning rate ${LR}..."
            python train.py --cfg_file cfgs/custom_models/pointrcnn_base_radii_range.yaml --epochs $EPOCH --batch_size $BATCH_SIZE --lr $LR --extra_tag "exp_${EPOCH}_epochs_${BATCH_SIZE}_batch_lr_${LR}" > "logs/exp_${EPOCH}_${BATCH_SIZE}_lr_${LR}.log" 2>&1
            echo "Training for ${EPOCH} epochs with batch size ${BATCH_SIZE} and learning rate ${LR} completed."
        done
    done
done

echo "All experiments completed."
