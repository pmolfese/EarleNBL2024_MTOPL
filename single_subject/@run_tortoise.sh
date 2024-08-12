#!/bin/bash

#first need to check for input files

current=`pwd`

for aSub in $@
do
	echo $aSub
	cd $aSub
	cd dti
	pwd
	nifti_base=`ls *AP*.bvec | head -1 | sed 's/.bvec//'`
	nifti_base2=`ls *PA*.bvec | head -1 | sed 's/.bvec//'`

	echo $nifti_base	
	echo $nifti_base2

	if [ ! -e ${nifti_base}.nii ]; then
		gunzip ${nifti_base}.nii.gz
	fi

	if [ ! -e ${nifti_base2}.nii ]; then
		gunzip ${nifti_base2}.nii.gz
	fi

	if [ -e $current/${aSub}/anat/T2_ss_acpc.nii ]; then
		echo "T2 image found!"

		if [ ! -e ${nifti_base}_proc ]; then
			ImportNIFTI \
			-i ${nifti_base}.nii \
			-p vertical \
			-b ${nifti_base}.bval \
			-v ${nifti_base}.bvec

			cd ${nifti_base}_proc
			DIFFPREP \
			-i ${nifti_base}.list \
			-o ${aSub}_${nifti_base}_DIFFPREP_DMC \
			-s ../../anat/T2_ss_acpc.nii \
			--reg_settings tortoise_prep.txt
		fi

		cd ../
		
		if [ ! -e ${nifti_base2}_proc ]; then
			ImportNIFTI \
			-i ${nifti_base2}.nii \
			-p vertical \
			-b ${nifti_base2}.bval \
			-v ${nifti_base2}.bvec

			cd ${nifti_base2}_proc
			DIFFPREP \
			-i ${nifti_base2}.list \
			-o ${aSub}_${nifti_base2}_DIFFPREP_DMC \
			-s ../../anat/T2_ss_acpc.nii \
			--reg_settings tortoise_prep.txt 
		fi
	fi	
		
	cd $current
done

