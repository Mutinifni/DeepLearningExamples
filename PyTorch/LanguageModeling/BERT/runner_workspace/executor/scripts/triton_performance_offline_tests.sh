set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

python triton/run_performance_on_triton.py \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--input-data ${SHARED_DIR}/input_data/data.json \
	--input-shapes input__0:${MAX_SEQ_LENGTH} \
	--input-shapes input__1:${MAX_SEQ_LENGTH} \
	--input-shapes input__2:${MAX_SEQ_LENGTH} \
	--batch-sizes ${BATCH_SIZE} \
	--number-of-triton-instances ${TRITON_INSTANCES} \
	--number-of-model-instances ${TRITON_GPU_ENGINE_COUNT} \
	--batching-mode static \
	--evaluation-mode offline \
	--performance-tool perf_analyzer \
	--result-path ${SHARED_DIR}/triton_performance_offline.csv

