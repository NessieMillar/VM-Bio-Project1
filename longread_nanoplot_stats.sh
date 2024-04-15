#!/bin/bash
#SBATCH --job-name=longread_pass_and_fail_nanoplotstats
#SBATCH --partition=hpc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem=10g
#SBATCH --time=12:00:00
#SBATCH --output=/workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/Output_and_Error_barcode02_assembly/%x.out
#SBATCH --error=/workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/Output_and_Error_barcode02_assembly/%x.err


# source home profile 
source $HOME/.bash_profile

# activate environment with nanoplot. This allows us to use NanoPlot 
conda activate /shared/conda/shared 

## make a directory for nanoplot stats
# directory for just pass data
mkdir -p /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_pass_output

# directory for just fail data
mkdir /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_fail_output

# directory for fail pass data
mkdir /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_failpass_output

# run nanoplot on all the longread pass data
# N50 flag adds the a mark for the N50 in the read length histogram
NanoPlot -t 8 --fastq /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/all_input_reads/fastq_pass/barcode02/*.fastq.gz --maxlength 40000 --plots dot --N50 -o /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_pass_output

# run nanoplot on all of the longread fail data
NanoPlot -t 8 --fastq /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/all_input_reads/fastq_fail/barcode02/*.fastq.gz --maxlength 40000 --plots dot --N50 -o /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_fail_output

# run nanoplot on the combined longread fail pass data
NanoPlot -t 8 --fastq /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/longread_mergedfiles/longread_failpass_merger.fastq.gz --maxlength 40000 --plots dot --N50 -o /workhere/students_2023/Group_2_VDJ/DR_individual_assembly_barcode02/nanoplot_output_stats/longread_failpass_output

# get job id
echo "The Job ID for this job is: $SLURM_JOB_ID"
