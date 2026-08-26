import numpy as np


# PROJECT=eevw
# PARAMS=real
# python /Users/jlanders/PycharmProjects/ccm_proj_tools/carc2/make_params.py --project hol_temp_tsi_ccm --parameters real --inds 1 10 --vars erb wu surrogate temp tsi neither

# python make_params.py --project $PROJECT --parameters $PARAMS --inds 1 25 --vars erb wu surrogate temp tsi neither --flags Tp_tau2 Tp_tau3
# makes parameters for the specified project,
# written to the specified parameter file,
# with surrogates numbered 1 to 25,
# using specified variable_ids (default to all combinations)
# and surrogates for temp and tsi (default to neither),
# and additional flags Tp_tau2 and Tp_tau3



# Define a dictionary of parameters to be used for generating combinations later
parameters_d = {
    'tau': {
        'values': np.arange(3, 9, 1)  # A range of tau values from 4 to 12
    },
    'E':  {
        'values': np.arange(3, 11, 1)  # A range of embedding dimensions (E) from 4 to 15
    },
    'train_len': {
        'values': [None]  # Train length value, set to None for now
    },
    'train_ind_i': {
        'values': [0]  # Train index value, set to 0 by default
    },
    'knn': {
        'values': [20]  # Number of nearest neighbors (knn) fixed at 20
    },
    'Tp_flag': {
        'values': [None]  # Placeholder for Tp flag values
    },
    'Tp': {
        'values': [1]  # Prediction horizon (Tp) fixed at 20
    },
    'lag': {
        'values': np.arange(0, 37, 2)  # A range of lag values from -38 to 38 in steps of 4
    },
    'Tp_lag_total': {
        'values': [32]  # Total lag value fixed at 32
    },
    'sample': {
        'values': [100]#[100]  # Sample size fixed at 100
    },
    'weighted': {
        'values': [False]  # Whether to use weighted calculation, set to False
    },
    'target_var': {
        'values': []  # Placeholder for target variable values
    },
    'col_var': {
        'values': []  # Placeholder for column variable values
    },
    'surr_var': {
        'values': ['neither']  # Surrogate variable, default is 'neither'
    },
    'surr_num': {
        'values': [0]#np.arange(1, 11, 1)  # Range of surrogate numbers from 1 to 19
    },
}


