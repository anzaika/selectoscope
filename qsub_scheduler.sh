qsub -l hostname='hpc06' -pe smp 16 -R y worker_init.sh
