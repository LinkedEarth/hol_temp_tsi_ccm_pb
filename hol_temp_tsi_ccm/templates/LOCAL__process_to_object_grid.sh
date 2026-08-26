#!/bin/bash

PROJECT=$1
echo "Setting up object grid calculations for project $PROJECT"

export CODE_DIR="/Users/jlanders/PycharmProjects/CCM_software/cedar_util"
export PROJECT_DIR="/Users/jlanders/PycharmProjects/hol_temp_tsi_ccm"

eval "$(conda shell.bash hook)"
conda activate hol_ccm_local_cedar_env

export PYTHONPATH="${PYTHONPATH}:$CODE_DIR"
export PYTHONPATH="${PYTHONPATH}:$PROJECT_DIR/tmp_utils"

export SCRIPT="object_grid"
export FILE="${PROJECT}_obj_grid.joblib"
export GROUP_CSV="E_tau_grps"

########################
cd $PROJECT_DIR

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
#export PROJECT="GISP2Martin24TanomLinear_Wu18TSILinear"
export LOG_DIR="${PROJECT_DIR}/${PROJECT}/slurm/${SCRIPT}"
mkdir -p $LOG_DIR
export FILE="${PROJECT}_obj_grid.joblib"


OUT_LOG="$LOG_DIR/${TIMESTAMP}_out.log"
ERR_LOG="$LOG_DIR/${TIMESTAMP}_err.log"
exec > >(ts '[%Y-%m-%d %H:%M:%S]' >> "$OUT_LOG") 2> >(ts '[%Y-%m-%d %H:%M:%S]' >> "$ERR_LOG")

START=0
END=65
#START=31
#END=32
PARALLEL=1
export TMP_DIR="${PROJECT_DIR}/${PROJECT}/tmp"

echo "$PROJECT: Calculating object_grid cells: (${START}:${END}); $(date)" > /dev/tty
#--flags aggregate_libsize
seq $START 1 $END | xargs -n 1 -P $PARALLEL python3 -W ignore::RuntimeWarning $CODE_DIR/runners/${SCRIPT}.py --project $PROJECT --file $FILE  --group_file $GROUP_CSV --dir $TMP_DIR --ind
echo "Finished with configurations: (${START}:${END}); $(date)" > /dev/tty
