set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

python triton/run_performance_on_triton.py \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--input-data ${SHARED_DIR}/input_data/data.json \
	--batch-sizes ${BATCH_SIZE} \
	--number-of-triton-instances ${TRITON_INSTANCES} \
	--number-of-model-instances ${TRITON_GPU_ENGINE_COUNT} \
	--batching-mode dynamic \
	--evaluation-mode online \
	--measurement-request-count 500 \
	--warmup \
	--performance-tool perf_analyzer \
	--result-path ${SHARED_DIR}/triton_performance_online.csv

