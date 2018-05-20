catlas_base = 'out'
ksize = 31
input_sequences = expand('{catlas_base}.fq.gz', catlas_base=catlas_base)

rule all:
    input:
        expand("{catlas_base}.nonreci.k{ksize}.count.txt",
               catlas_base=catlas_base, ksize=ksize)

# count non-reciprocal edges
rule count:
    input:
        "{catlas_base}/bcalm.{catlas_base}.k{ksize}.unitigs.gfa"
    output:
        "{catlas_base}.nonreci.k{ksize}.count.txt"
    shell:
        "detect_non_reci_edges.py {input} | wc -l > {output}"

# build GFA
rule gfa:
    input:
        "{catlas_base}/bcalm.{catlas_base}.k{ksize}.unitigs.fa"
    output:
        "{catlas_base}/bcalm.{catlas_base}.k{ksize}.unitigs.gfa"
    shell:
        "convertToGFA.py {input} {output} {ksize}"
        

# build cDBG using bcalm
rule bcalm_cdbg:
     input:
        "bcalm.{catlas_base}.k{ksize}.inputlist.txt"
     output:
        "{catlas_base}/bcalm.{catlas_base}.k{ksize}.unitigs.fa"
     shell:
        "bcalm -in bcalm.{catlas_base}.k{ksize}.inputlist.txt -out {catlas_base}/bcalm.{catlas_base}.k{wildcards.ksize} -kmer-size {wildcards.ksize} -abundance-min 1 >& {output}.log.txt"

# create list of input files for bcalm
rule bcalm_cdbg_inpfiles:
     input:
        input_sequences
     output:
        "bcalm.{catlas_base}.k{ksize}.inputlist.txt"
     run:
        with open("bcalm.{catlas_base}.k{ksize}.inputlist.txt".format(catlas_base=catlas_base, ksize=ksize), 'wt') as fp:
            for name in input_sequences:
                fp.write('{}\n'.format(name))
