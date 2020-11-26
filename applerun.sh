#!/bin/bash
#$ -M svandext@nd.edu
#$ -m abe
#$ -pe smp 8

module load julia

julia diversity.jl "apple.fasta"
julia diversity.jl "Haw.fasta"
