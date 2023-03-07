set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${FORMAT}" == "ts-trace" || "${FORMAT}" == "ts-script" ]]; then
	export CONFIG_FORMAT="torchscript"
else
	export CONFIG_FORMAT="${FORMAT}"
fi

if [[ "${FORMAT}" == "trt" ]]; then
	export MBS="0"
else
	export MBS="${MAX_BATCH_SIZE}"
fi

model-navigator triton-config-model \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--model-version 1 \
	--model-path ${SHARED_DIR}/converted_model \
	--model-format ${CONFIG_FORMAT} \
	--model-control-mode ${TRITON_LOAD_MODEL_METHOD} \
	--verbose \
	--load-model \
	--load-model-timeout-s 100 \
	\
	--backend-accelerator ${ACCELERATOR} \
	--tensorrt-precision ${ACCELERATOR_PRECISION}  \
	--max-batch-size ${MBS} \
	--preferred-batch-sizes ${TRITON_PREFERRED_BATCH_SIZES} \
	--max-queue-delay-us ${TRITON_MAX_QUEUE_DELAY} \
	--engine-count-per-device gpu=${TRITON_GPU_ENGINE_COUNT}

