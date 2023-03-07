set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

mkdir -p ${SHARED_DIR}/input_data

python triton/prepare_input_data.py \
	--dataloader triton/dataloader.py \
	--input-data-dir ${SHARED_DIR}/input_data \
	\
	--batch-size ${MAX_BATCH_SIZE} \
	--max-seq-length ${MAX_SEQ_LENGTH} \
	--predict-file ${DATASETS_DIR}/data/squad/v1.1/dev-v1.1.json \
	--vocab-file ${DATASETS_DIR}/data/google_pretrained_weights/uncased_L-24_H-1024_A-16/vocab.txt

