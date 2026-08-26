#!/bin/bash

PROJECT=$1
echo "Setting up object grid calculations for project $PROJECT"

export CODE_DIR="/Users/jlanders/PycharmProjects/CCM_software/cedar_util"
export PROJECT_DIR="/Users/jlanders/PycharmProjects/hol_temp_tsi_ccm"

eval "$(conda shell.bash hook)"
conda activate hol_ccm_local_cedar_env

export PYTHONPATH="${PYTHONPATH}:$CODE_DIR"
export PYTHONPATH="${PYTHONPATH}:$PROJECT_DIR/tmp_utils"

export SCRIPT="to_parquet"
export FILE="${PROJECT}_obj_grid.joblib"
export GROUP_CSV="E_tau_grps"
export OUTPUT_DIR=calc_local_tmp/intermediate/csv
CPUS=4

########################
cd $PROJECT_DIR

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
export LOG_DIR="${PROJECT_DIR}/${PROJECT}/slurm/${SCRIPT}"
mkdir -p $LOG_DIR

OUT_LOG="$LOG_DIR/${TIMESTAMP}_out.log"
ERR_LOG="$LOG_DIR/${TIMESTAMP}_err.log"
exec > >(ts '[%Y-%m-%d %H:%M:%S]' >> "$OUT_LOG") 2> >(ts '[%Y-%m-%d %H:%M:%S]' >> "$ERR_LOG")

START=0
END=65
PARALLEL=3

echo "$PROJECT: Calculating object_grid cells: (${START}:${END}); $(date)" > /dev/tty

seq $START 1 $END | xargs -n 1 -P $PARALLEL python3 -W ignore::RuntimeWarning $CODE_DIR/runners/${SCRIPT}.py --project $PROJECT --proj_dir $PROJECT_DIR --parameters ${GROUP_CSV}.csv --cpus $CPUS --inds
echo "Finished with configurations: (${START}:${END}); $(date)" > /dev/tty
