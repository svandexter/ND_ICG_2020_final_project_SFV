#!/bin/bash
#$ -M svandext@nd.edu
#$ -m abe
#$ -pe smp 10
#$ -N Diachasma_host_races

module load bio/2.0

#move RAD sequences and barcodes
#trim the haw race sequences

#trimmomatic SE -threads 8 -phred33 Fenn_Haw_S1_L001_R1_001.fastq.gz Fenn_Haw_S1_L001_R1_001.trim.fastq.gz ILLUMINACLIP:Fennvillebarcodes.fasta:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
#trimmomatic SE -threads 8 -phred33 Fenn-apple_S1_L001_R1_001.fastq.gz Fenn-apple_S1_L001_R1_001.trim.fastq.gz ILLUMINACLIP:Fennvillebarcodes.fasta:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#index the Diachasma genome
#bwa index sequence.fasta

#align apple race
#Fenn-apple_S1_L001_R1_001.trim.fastq.gz_variants.vcf
#for x in Fenn-apple_S1_L001_R1_001.trim.fastq.gz
#do
#	echo "on file $x"
#	apple_forward=Fenn-apple_S1_L001_R1_001.trim.fastq.gz
#	apple_sam=Fenn-apple_S1_L001_R1_001.trim.fastq.gz.aligned.sam
#	apple_bam=Fenn-apple_S1_L001_R1_001.trim.fastq.gz.aligned.bam
#	apple_sorted_bam=Fenn-apple_S1_L001_R1_001.trim.fastq.gz.aligned.sorted.bam
#	apple_raw_bcf=Fenn-apple_S1_L001_R1_001.trim.fastq.gz_raw.bcf
#	apple_variants=Fenn-apple_S1_L001_R1_001.trim.fastq.gz_variants.vcf
#	apple_final_variants=Fenn-apple_S1_L001_R1_001.trim.fastq.gz_final_variants.vcf

#	bwa mem -t 10 sequence.fasta  $apple_forward > $apple_sam

#convert to bam
#	samtools view -@ 10 -S -b $apple_sam > $apple_bam
#	samtools sort -@ 10 -o $apple_sorted_bam $apple_bam
#	samtools index $apple_sorted_bam
#calculate read position
##	bcftools mpileup --threads 10 -O b -o $apple_raw_bcf -f sequence.fasta $apple_sorted_bam
#call snps, haplodiploid plidy is X
#	bcftools call --threads 10 --ploidy X -m -v -o $apple_variants $apple_raw_bcf 
#filter snps, generate final vcf
#	vcfutils.pl varFilter $apple_variants > $apple_final_variants
done

#align haw race

#for y in Fenn_Haw_S1_L001_R1_001.trim.fastq.gz
#do
#	echo "on file $y"
#	haw_forward=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz
#	haw_sam=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz.aligned.sam
#	haw_bam=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz.aligned.bam
#	haw_sorted_bam=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz.aligned.sorted.bam
#	haw_raw_bcf=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz_raw.bcf
#	haw_variants=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz_variants.vcf
#	haw_final_variants=Fenn_Haw_S1_L001_R1_001.trim.fastq.gz_final_variants.vcf
#
#	bwa mem -t 10 sequence.fasta  $haw_forward > $haw_sam

#convert to bam
 #       samtools view -@ 10 -S -b $haw_sam > $haw_bam
 #       samtools sort -@ 10 -o $haw_sorted_bam $haw_bam
 #       samtools index $haw_sorted_bam
#calculate read position
    #    bcftools mpileup --threads 10 -O b -o $haw_raw_bcf -f sequence.fasta $haw_sorted_bam
#call snps, ploidy = 2
     #   bcftools call --threads 10 --ploidy X -m -v -o $haw_variants $haw_raw_bcf
#filter snps, generate final vcf
      #  vcfutils.pl varFilter $haw_variants > $haw_final_variants
#done

#sed -n '1~4s/^@/>/p;2~4p' Fenn_Haw_S1_L001_R1_001.fastq > Haw.fasta
#sed -n '1~4s/^@/>/p;2~4p' Fenn-apple_S1_L001_R1_001.fastq > apple.fasta

wc -l Fenn_Haw_S1_L001_R1_001.trim.fastq.gz_variants.vcf
wc -l Fenn_apple_S1_L001_R1_001.trim.fastq.gz_variants.vcf

module load julia

julia sympatcompare.jl
julia diversity.jl "apple.fasta"
julia diversity.jl "Haw.fasta"
