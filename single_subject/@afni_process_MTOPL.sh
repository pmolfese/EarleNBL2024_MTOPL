#!/bin/bash

current=`pwd`

for aS in $@
do
	echo $aS
	cd $aS

	
	stimlabels="T1_Dental T1_Retroflex T2_Dental T2_Retroflex"
	stimfiles="stim_times/T1Dental.txt stim_times/T1Retroflex.txt stim_times/T2Dental.txt stim_times/T2Retroflex.txt"


	afni_proc.py -subj_id ${aS} -out_dir ${aS}.MTOPL \
	-blocks align tlrc volreg mask blur scale regress \
	-dsets func/ep2d*.nii.gz \
	-copy_anat anat/t1*.nii.gz \
	-tcat_remove_first_trs 0 \
	-volreg_align_e2a \
	-volreg_align_to first \
	-volreg_tlrc_warp \
	-align_opts_aea -giant_move \
	-tlrc_NL_warp \
	-blur_in_automask \
	-blur_size 6 \
	-regress_stim_labels ${stimlabels} \
	-regress_stim_types times \
	-regress_stim_times ${stimfiles} \
	-regress_basis 'GAM' \
	-regress_censor_motion 0.3 \
	-regress_censor_outliers 0.1 \
	-regress_3dD_stop \
	-regress_opts_3dD \
		-jobs 10 \
		-gltsym 'SYM: +T1_Dental -T2_Dental' -glt_label 1 Dental_T1-T2 \
		-gltsym 'SYM: +T1_Retroflex -T2_Retroflex' -glt_label 2 Retroflex_T1-T2 \
		-gltsym 'SYM: +T1_Dental -T1_Retroflex' -glt_label 3 T1_Dental-Retroflex \
		-gltsym 'SYM: +T2_Dental -T2_Retroflex' -glt_label 4 T2_Dental-Retroflex \
		-gltsym 'SYM: +T1_Dental +T1_Retroflex' -glt_label 5 T1 \
		-gltsym 'SYM: +T2_Dental +T2_Retroflex' -glt_label 6 T2 \
	-regress_run_clustsim no \
	-regress_reml_exec \
	-regress_est_blur_epits \
	-regress_est_blur_errts \
	-bash -execute
	
	cd $current
done
