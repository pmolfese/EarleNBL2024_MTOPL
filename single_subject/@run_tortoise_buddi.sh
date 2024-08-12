#!/bin/bash

current=`pwd`

for aSub in $@
do
	echo $aSub
	cd $aSub

	echo "DR_BUDDI_withoutGUI --up_data dti/*AP*_proc/DTI32*AP*_proc.list --down_data dti/*PA*_proc/DTI*PA*_proc.list --structural anat/T2_ss_acpc.nii --distortion_level medium"

	DR_BUDDI_withoutGUI \
	--up_data dti/*AP*_proc/DTI*AP*_proc.list \
	--down_data dti/*PA*_proc/DTI*PA*_proc.list \
	--structural anat/T2_ss_acpc.nii \
	--distortion_level medium 

	cd $current
done
