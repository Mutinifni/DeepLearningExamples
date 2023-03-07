set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${EXPORT_FORMAT}" == "ts-trace" || "${EXPORT_FORMAT}" == "ts-script" ]]; then
	export FORMAT_SUFFIX="pt"
else
	export FORMAT_SUFFIX="${EXPORT_FORMAT}"
fi
if [ "${EXPORT_FORMAT}" != "${FORMAT}" ]; then
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
		--inputs input__0:${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH}:int32 \
		--inputs input__1:${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH}:int32 \
		--inputs input__2:${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH}:int32 \
		--min-shapes input__0=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__1=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__2=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		--max-shapes input__0=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__1=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__2=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		--opt-shapes input__0=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__1=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		input__2=${MAX_BATCH_SIZE},${MAX_SEQ_LENGTH} \
		--max-batch-size ${MAX_BATCH_SIZE} \
		--tensorrt-max-workspace-size 8589934592 \
		--atol 2 output__0=5.0 \
		output__1=5.0 \
		--rtol 1 output__0=5.0 \
		output__1=5.0 \
		| grep -v "broadcasting input1 to make tensors conform"
		else
			mv ${SHARED_DIR}/exported_model.${FORMAT_SUFFIX} ${SHARED_DIR}/converted_model
			mv ${SHARED_DIR}/exported_model.${FORMAT_SUFFIX}.yaml ${SHARED_DIR}/converted_model.yaml 2>/dev/null || true
fi

