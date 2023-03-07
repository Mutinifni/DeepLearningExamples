set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${EXPORT_FORMAT}" == "torchscript" ]]; then
	export FORMAT_SUFFIX="pt"
else
	export FORMAT_SUFFIX="${EXPORT_FORMAT}"
fi
model-navigator convert \
	--model-name ${MODEL_NAME} \
	--model-path ${SHARED_DIR}/exported_model.${FORMAT_SUFFIX} \
	--output-path ${SHARED_DIR}/converted_model \
	--target-formats ${FORMAT} \
	--target-precisions ${PRECISION} \
	--launch-mode local \
	--override-workspace \
	--verbose \
	\
	--onnx-opsets 13 \
	--max-batch-size ${MAX_BATCH_SIZE} \
	--container-version 21.12 \
	--max-workspace-size 10000000000 \
	--atol OUTPUT__0=100 \
	--rtol OUTPUT__0=100


