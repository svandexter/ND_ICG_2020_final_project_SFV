#! usr/bin/env julia
using Pkg
Pkg.activate(".")

Pkg.add("FileIO")
using FileIO

#Pkg.add("BioSequences")
using BioSequences

#Pkg.add("FASTX")
using FASTX

#Pkg.add("ArgParse")
using ArgParse

#Pkg.add("GeneticVariation")
using GeneticVariation

#Retrieve input fasta
input=ARGS[1]

#Retrieve input fasta
fasta=open(FASTX.FASTA.Reader, input)

#Initialize array for nucelotide sequences 
sequences=BioSequence{DNAAlphabet{4}}[]

#Retrieve sequences from fasta
for seq in fasta
	#Add each sequence to array
    push!(sequences, FASTX.FASTA.sequence(seq))
end

#Create variable that contains unique sequence counts
composition=BioSequences.composition(sequences)

#Compute allele frequencies
println("Allele frequencies:")
gene_frequencies(composition)

#Compute measures of genetic diversity
mutations=avg_mut(sequences)
nucleotidediversity=NL79(sequences)

open("analysisoutput.txt", "a") do io
println(io, input, "average mutations:", mutations)
println(io, input, "nucleotide diversity:", nucleotidediversity)
end

