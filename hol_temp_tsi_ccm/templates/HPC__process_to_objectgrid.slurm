#!/bin/bash
#SBATCH --time=00:200:00                # Time limit
#SBATCH --ntasks=65                      # numer of tasks
#SBATCH --cpus-per-task=1              # CPUs per task
#SBATCH --mem-per-cpu=16GB               # Memory per CPU

NUM_TASKS=$SLURM_NTASKS         # number of workers we have

SEQ_START=0 #0 #916     # starting index, inclusive 2270
SEQ_END=65
PARALLELISM=1   # within a given task (node), how many should we run at one? should not exceed cpus-per-task

export PARAMS="E_tau_grps_run.csv"
export PROJECT=Hobart23d18ONAstack_Berger91Insol65NJuneSol
export OUTPUT_DIR=calc_refactor

SEQ_COUNT=$(( SEQ_END - SEQ_START ))
MAX_SEQ=$(( SEQ_END - 1 ))

echo "sequence: [$SEQ_START, $SEQ_END); count=$SEQ_COUNT"

export CODE_DIR="/project2/julieneg_1707/lplander/cedar_util"
export PROJECT_DIR="/project2/julieneg_1707/lplander/hol_temp_tsi_ccm"

export PYTHONPATH="${PYTHONPATH}:$CODE_DIR"
cd $PROJECT_DIR
date

CHUNK_SIZE=$(( (SEQ_COUNT + NUM_TASKS - 1) / NUM_TASKS )) # Calculate chunk size, rounding up
echo "chunk size with ntasks=$NUM_TASKS: $CHUNK_SIZE"
echo "parallelism=$PARALLELISM with $SLURM_CPUS_PER_TASK cpus per task"

if [[ $PARALLELISM -lt 1 || $PARALLELISM -gt $SLURM_CPUS_PER_TASK ]];then
    echo "bad parallelism=$PARALLELISM with $SLURM_CPUS_PER_TASK cpus per task"
    exit 1
fi

# Function to process each chunk
process_chunk() {
    local start=$1
    local end=$2
    local parallel=$3
    eval "$(conda shell.bash hook)"
#    eval "pip install pyyaml"
    conda activate edm_hpc_env
    local MYHOST=`hostname`
    local MYDATE=`date`
    local NPROC=`nproc`
    local PROJECT=Hobart23d18ONAstack_Berger91Insol65NJuneSol
    local CODE_DIR="/project2/julieneg_1707/lplander/cedar_util"
    local FILE="${PROJECT}_obj_grid.joblib"
    local GROUP_CSV="E_tau_grps_run"
    local CPUS=$((SLURM_CPUS_PER_TASK / parallel))
    local TMP_DIR="${PROJECT_DIR}/${PROJECT}/tmp"

    echo "Processing chunk on $MYHOST with nproc=$NPROC and cpus=$CPUS: $start to $end, parallel=$parallel, at $MYDATE"
#    sleep 10
    seq $start 1 $end | xargs -n 1 -P $parallel python3 -W ignore::RuntimeWarning $CODE_DIR/runners/object_grid.py --project $PROJECT --file $FILE --group_file $GROUP_CSV --dir $TMP_DIR --ind
    local MYDATE=`date`
    echo "Finished processing chunk on $MYHOST: $start to $end at $MYDATE"
}

# Export the function to be used by srun
export -f process_chunk

# Use srun to distribute the work across nodes, ensuring conda environment activation
for i in $(seq 0 $((NUM_TASKS - 1))); do
    start=$(( SEQ_START + i * CHUNK_SIZE ))
    end=$(( start + (CHUNK_SIZE - 1) ))
    if [ $start -lt $MAX_SEQ ]; then
        if [ $end -gt $MAX_SEQ ]; then
            end=$MAX_SEQ
        fi
        echo "submitting $start $end"
        srun --nodes=1 --ntasks=1 --cpus-per-task=$SLURM_CPUS_PER_TASK --mem-per-cpu=$SLURM_MEM_PER_CPU --exclusive bash -c "process_chunk $start $end $PARALLELISM" &
    fi
done

wait

date