set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${EXPORT_FORMAT}" == "ts-trace" || "${EXPORT_FORMAT}" == "ts-script" ]]; then
	export FORMAT_SUFFIX="pt"
else
	export FORMAT_SUFFIX="${EXPORT_FORMAT}"
fi
python3 triton/export_model.py \
	--input-path triton/model.py \
	--input-type pyt \
	--output-path ${SHARED_DIR}/exported_model.${FORMAT_SUFFIX} \
	--output-type ${EXPORT_FORMAT} \
	--ignore-unknown-parameters \
	--onnx-opset 13 \
	\
	--checkpoint ${CHECKPOINT_DIR}/ \
	--precision ${EXPORT_PRECISION} \
	\
	--dataloader triton/dataloader.py \
	--dataset ${DATASETS_DIR}/${DATASET} \
	--batch-size 1

