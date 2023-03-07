set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

if [[ "${EXPORT_FORMAT}" == "ts-trace" || "${EXPORT_FORMAT}" == "ts-script" ]]; then
	export FORMAT_SUFFIX="pt"
else
	export FORMAT_SUFFIX="${EXPORT_FORMAT}"
fi
if [[ "${EXPORT_FORMAT}" == "trt" ]]; then
	export FLAG="--fixed-batch-dim"
else
	export FLAG=""
fi
python3 triton/export_model.py \
	--input-path triton/model.py \
	--input-type pyt \
	--output-path ${SHARED_DIR}/exported_model.${FORMAT_SUFFIX} \
	--output-type ${EXPORT_FORMAT} \
	--dataloader triton/dataloader.py \
	--ignore-unknown-parameters \
	--onnx-opset 13 \
	${FLAG} \
	\
	--config-file bert_configs/large.json \
	--checkpoint ${CHECKPOINT_DIR}/bert_large_qa.pt \
	--precision ${EXPORT_PRECISION} \
	\
	--vocab-file ${DATASETS_DIR}/data/google_pretrained_weights/uncased_L-24_H-1024_A-16/vocab.txt \
	--max-seq-length ${MAX_SEQ_LENGTH} \
	--predict-file ${DATASETS_DIR}/data/squad/v1.1/dev-v1.1.json \
	--batch-size ${MAX_BATCH_SIZE}

