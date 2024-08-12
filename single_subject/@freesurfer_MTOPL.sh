#!/bin/bash

module load freesurfer/6.0.0
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export SUBJECTS_DIR=/data/molfesepj/MTOPL/freesurfer


for aS in $@
do
	segfile=`ls $aS/anat/T2* | head -1`
	echo "recon-all -s ${aS} -i ${aS}/anat/t1*.nii.gz -T2 ${segfile} -3T -all -openmp 4 -hippocampal-subfields-T2 ${segfile} ID"
	recon-all -s ${aS} -i ${aS}/anat/t1*.nii.gz -T2 ${segfile} -3T -all -openmp 4 -hippocampal-subfields-T2 ${segfile} ID -T2pial
done
