#!/bin/bash

module load R
module load afni/current-openmp

3dMVM -prefix MTOPL_MVM \
-jobs 24 \
-bsVars '1' \
-wsVars 'Day*Cond*Talker' \
-GES \
-mask TT_Mask.nii.gz \
-num_glt 5 \
-gltLabel 1 'Day1-Day2_T1' -gltCode 1 'Day : 1*day1 -1*day2 Talker : 1*T1' \
-gltLabel 2 'Day1-Day2_T2' -gltCode 2 'Day : 1*day1 -1*day2 Talker : 1*T2' \
-gltLabel 3 'Talker1-Talker2_Day1' -gltCode 3 'Talker : 1*T1 -1*T2 Day : 1*day1' \
-gltLabel 4 'Talker1-Talker2_Day2' -gltCode 4 'Talker :	1*T1 -1*T2 Day : 1*day2' \
-gltLabel 5 'Day1-Day2' -gltCode 5 'Day : 1*day1 -1*day2' \
-dataTable MTOPL_Table.txt
