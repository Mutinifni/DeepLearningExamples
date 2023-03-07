set -x
set -e
export PYTHONUNBUFFERED=1
export PYTHONPATH=`pwd`

mkdir -p ${SHARED_DIR}/input_data

python triton/prepare_input_data.py \
	--input-data-dir ${SHARED_DIR}/input_data/ \
	--dataset ${DATASETS_DIR}/${DATASET} \
	--checkpoint ${CHECKPOINT_DIR}/ \

