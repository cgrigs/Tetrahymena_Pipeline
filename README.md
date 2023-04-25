# Tetrahymena Pipeline

## Description

This project aims to explore mutations in Tetrahymena thermophila. The Tetrahymena thermophila variant calling Pipeline is a workflow that automates the process of variant calling from raw sequencing data. It includes multiple steps, such as data preprocessing, alignment, variant calling, and post-processing, all orchestrated using Snakemake, a powerful workflow management system, with job submission to Slurm, a popular job scheduler for HPC clusters.

## Requirements

Snakemake: Install Snakemake on your local machine or the HPC cluster following the installation instructions in the Snakemake documentation.

Slurm: Set up Slurm on your HPC cluster according to your cluster's policies and resources. Ensure that you have the necessary permissions to submit and manage jobs on Slurm.

## Installation

1. Clone the Tetrahymena Pipeline repository:

    ``` sh
    git clone https://github.com/cgrigs/Tetrahymena_Pipeline.git
    cd tetrahymena-pipeline
    ```

2. Configure Slurm profile: Create a Slurm profile for your HPC cluster by creating a directory named slurm inside the profiles directory in the pipeline directory, and create a config.yaml file inside that directory with the Slurm-specific configuration. Here's an example of a Slurm profile for Snakemake:

``` yaml
# tetrahymena-pipeline/profiles/slurm/config.yaml

# Specify the Slurm partition to submit jobs to
partition: my_partition

# Specify additional Slurm parameters for job submission
cluster:
    time: "24:00:00"
    mem: "8G"
    cores: 4
    queue: my_queue
```

Customize the partition, time, mem, cores, and queue parameters in the config.yaml file based on your HPC cluster's configuration.

## Usage

1. Edit the configuration: Open the config.yaml file in the pipeline directory and customize the parameters according to your data and analysis requirements. This may include specifying input files, reference genome, output directories, and other parameters.

2. Run the pipeline: Submit the Snakemake workflow to Slurm for execution using the following command:

    ``` sh

    snakemake --profile profiles/slurm
    ```

    This will submit the jobs in the pipeline to Slurm for execution, utilizing the Slurm parameters specified in the Slurm profile.

3. Monitor the pipeline: Monitor the progress of the pipeline using the Slurm job status commands and Snakemake's built-in progress reporting features.

4. Review the results: Once the pipeline completes, review the generated variant calling results in the specified output directories.

## Configuration

The Tetrahymena thermophila variant calling pipeline automates the variant calling process for Tetrahymena thermophila data using Snakemake with Slurm on an HPC cluster, providing a scalable and reproducible workflow for variant calling analysis. Please refer to the Snakemake documentation and your HPC cluster.
