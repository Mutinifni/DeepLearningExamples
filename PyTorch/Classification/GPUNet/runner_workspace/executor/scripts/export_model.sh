set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${EXPORT_FORMAT}" == "torchscript" ]]; then
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
	--torch-jit ${TORCH_JIT} \
	\
	--config /workspace/gpunet/configs/batch1/GV100/1.75ms.json \
	--checkpoint ${CHECKPOINT_DIR}/1.75ms.pth.tar \
	--precision ${EXPORT_PRECISION} \
	\
	--dataloader triton/dataloader.py \
	--val-path ${DATASETS_DIR}/ \
	--is-prunet False \
	--batch-size 1


