#!/usr/bin/env julia
using Pkg
Pkg.activate(".")
Pkg.add("FileIO")
using FileIO
using VCFTools
using GenomicFeatures
using GeneticVariation

#compare two VCF files
apple=("Fenn-apple_S1_L001_R1_001.trim.fastq.gz_variants.vcf")
Haw=("Fenn_Haw_S1_L001_R1_001.trim.fastq.gz_variants.vcf")
outvcf=("match.vcf.ref.vcf.gz")

@time conformgt_by_pos(apple, Haw, outvcf, "NW_021680342.1", 1:6701942, false)

fh = openvcf("match.vcf.ref.vcf.gz.ref.vcf.gz", "r")
open("analysisoutput.txt", "w") do io
for l in 1:35
    println(readline(fh))
end
close(fh)
end
