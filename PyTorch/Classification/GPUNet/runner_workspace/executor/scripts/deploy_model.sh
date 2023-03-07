set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

model-navigator triton-config-model \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--model-version 1 \
	--model-path ${SHARED_DIR}/converted_model \
	--model-format ${FORMAT} \
	--model-control-mode explicit \
	--load-model \
	--load-model-timeout-s 100 \
	--verbose \
	\
	--backend-accelerator ${BACKEND_ACCELERATOR} \
	--tensorrt-precision ${PRECISION} \
	--tensorrt-capture-cuda-graph \
	--tensorrt-max-workspace-size 10000000000 \
	--max-batch-size ${MAX_BATCH_SIZE} \
	--batching ${MODEL_BATCHING} \
	--preferred-batch-sizes ${MAX_BATCH_SIZE} \
	--engine-count-per-device gpu=${NUMBER_OF_MODEL_INSTANCES}


