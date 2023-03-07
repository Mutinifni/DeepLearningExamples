set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

python triton/run_performance_on_triton.py \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--input-data random \
	--batch-sizes 1 2 4 8 16 32 64 \
	--concurrency 1 \
	--evaluation-mode offline \
	--measurement-request-count 10 \
	--warmup \
	--performance-tool perf_analyzer \
	--result-path ${SHARED_DIR}/triton_performance_offline.csv


