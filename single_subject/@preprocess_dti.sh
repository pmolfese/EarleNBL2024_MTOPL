#!/bin/bash

module load afni/current-openmp

current=`pwd`

for aSub in $@
do
	echo $aSub
	cd $aSub/anat
	echo "Stripping T1"
        3dSkullStrip -input t1mprage*.nii.gz -prefix T1_ss -orig_vol
	3dcopy T1_ss+orig T1_ss.nii
	@auto_tlrc -base MNI152_1mm_uni+tlrc. -input T1_ss+orig -no_ss -init_xform CENTER -rigid_equiv
	3dcopy T1_ss.Xat.rigid+tlrc T1_ss_acpc.nii
	rm *.HEAD *.BRIK *.log *.1D


	echo "Stripping T2"
	T2file=`ls T2*.nii.gz | head -1`
	3dSkullStrip -input $T2file -prefix T2_ss -orig_vol
	align_epi_anat.py -anat T1_ss_acpc.nii -epi T2_ss+orig. -epi2anat -anat_has_skull no -epi_strip None -suffix _al2acpc -rigid_body -epi_base 0 -giant_move
	3dcopy T2_ss_al2acpc+orig. T2_ss_acpc.nii
	rm *.1D *.HEAD *.BRIK

	cd $current
done
