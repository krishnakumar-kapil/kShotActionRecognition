#!/bin/bash
#
#-----------------------------------------------------------------------------
# This Maverick job script is designed to create an Rstudio session on 
# visualization nodes through the SLURM batch system. Once the job
# is scheduled, check the output of your job (which by default is
# stored in your home directory in a file named Rstudio.out)
# and it will tell you the port number that has been setup for you so
# that you can attach via a separate web browser to any Maverick login 
# node (e.g., login1.maverick.tacc.utexas.edu).
#
# Note: you can fine tune the SLURM submission variables below as
# needed.  Typical items to change are the runtime limit, location of
# the job output, and the allocation project to submit against (it is
# commented out for now, but is required if you have multiple
# allocations).  
#
# To submit the job, issue: "sbatch /share/doc/slurm/job.Rstudio" 
#
# For more information, please consult the User Guide at: 
#
# http://www.tacc.utexas.edu/user-services/user-guides/maverick-user-guide
#-----------------------------------------------------------------------------
#
#SBATCH -J kshot_alexnet                            # Job name
#SBATCH -o job_outputs/kshot-alexnet-%j.out                     # Name of stdout output file (%j expands to jobId)
#SBATCH -p gpu                                      # Queue name
#SBATCH -N 1                                        # Total number of nodes requested (20 cores/node)
#SBATCH -n 1                                        # Total number of mpi tasks requested
#SBATCH --mail-user=kk28695@tacc.utexas.edu
#SBATCH --mail-type=end
#SBATCH -t 1:00:00                                  # Run time (hh:mm:ss) - 4 hours

module load cuda/8.0 cudnn/5.1
python3 one_shot_learning.py --dataset_type=kinetics_dynamic --controller_type=alex --batch_size=32 --image_width=128  --image_height=128 --seq_length=35 --summary_writer=True --model_saver=True
