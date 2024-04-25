#!/bin/bash

# Define a list of epoch values and batch sizes to test
EPOCH_VALUES=(10 20)
#EPOCH_VALUES=(50 100 200 300 400 500 600 700 800 900 1000 1500 2000)
BATCH_SIZES=(2 4 6)

# Loop through each batch size
for BATCH_SIZE in "${BATCH_SIZES[@]}"
do
    # Then loop through each epoch value
    for EPOCH in "${EPOCH_VALUES[@]}"
    do
        echo "Starting training for ${EPOCH} epochs with batch size ${BATCH_SIZE}..."
        python train.py --cfg_file cfgs/custom_models/pointrcnn_original.yaml --epochs $EPOCH --batch_size $BATCH_SIZE --extra_tag "exp_${EPOCH}_epochs_${BATCH_SIZE}_batch" > "logs/exp_${EPOCH}_${BATCH_SIZE}.log" 2>&1
        echo "Training for ${EPOCH} epochs with batch size ${BATCH_SIZE} completed."
    done
done

echo "All experiments completed."
