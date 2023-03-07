set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

python triton/run_performance_on_triton.py \
	--model-repository ${MODEL_REPOSITORY_PATH} \
	--model-name ${MODEL_NAME} \
	--input-data random \
	--batch-sizes 1 \
	--concurrency 8 16 24 32 40 48 56 64 72 80 88 96 104 112 120 128 136 144 152 160 168 176 184 192 200 208 216 224 232 240 248 256 \
	--evaluation-mode online \
	--measurement-request-count 500 \
	--warmup \
	--performance-tool perf_analyzer \
	--result-path ${SHARED_DIR}/triton_performance_online.csv


