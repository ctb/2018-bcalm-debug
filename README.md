# 2018-bcalm-debug - automate some bcalm testing

References: [bcalm for cDBG generation](https://github.com/GATB/bcalm)

The issue at hand: [issue 34](https://github.com/GATB/bcalm/issues/34)

## Anywhere:

Install BCALM & make sure `bcalm` is in your PATH, then:

```
git clone https://github.com/ctb/2018-bcalm-debug.git

cd 2018-bcalm-debug

snakemake
```

Output:

```
...
RESULT: 812 non-reciprocal edges detected; should be 0
...
```

## On MSU HPC:

To use @ctb's environment,

```
. ~ctb/py3/load.sh

export PATH=~ctb/research/bcalm:$PATH

git clone https://github.com/ctb/2018-bcalm-debug.git

cd 2018-bcalm-debug

snakemake
```
