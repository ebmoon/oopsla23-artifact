# OOPSLA 2023 Artifact

This is the artifact for paper #481 "Synthesizing Specifications". 


## System Requirements

* A 64-bit processor and operating system (amd64 machine recommended)
* Internet connection to download the artifact
* Memory: 8GB RAM or higher is recommended
* CPU (cores): CPU with four or more logical cores (3rd Gen Intel Xeon Scalable Ice Lake or better recommended)
* Secondary Memory: 10GB or higher is recommended

## Claims

### Claims supported by this artifact

The artifact supports the following claims:

1. Quantitative analysis Part 1: Performance
    * Application 1: Spyro[SMT] can synthesize best L-properties for 6/10 benchmark problems, and guarantee those 6 are best L-conjunction.
    * Application 1: Spyro[Sketch] can synthesize the best L-properties for 35/35 Spyro[Sketch] problems and guarantee that 34 out of 35 are the best L-conjunctions.
    * Application 2: Spyro[Sketch] can synthesize the best algebraic properties for 12/12 Spyro[Sketch] problems from the ArrayList, ArraySet, and HashMap modules, and guarantee that all they are the best L-conjunctions.
    * Application 3: Spyro[Sketch] can synthesize the best sensitivity L-properties for 18/18 Spyro[Sketch] problems about Hamming/edit distance on List functions, and guarantee that all they are the best L-conjunctions.
    * Application 4: Spyro[Sketch] can synthesize the best 4-bit inequalities for 9/9 Spyro[Sketch] problems from bit-vector operations, and guarantee that 8/9 are the best L-conjunctions.

 for 35/35 benchmark problems, and guarantee 34/35 are best L-conjunction.

2. Quantitative analysis Part 2: Soundness
    * Dafny successfully verified that 33/35 L-conjunctions synthesized by spyro[sketch] on non-SyGuS benchmarks.

3. The Algorithm 1 with line 12 is faster than the Algorithm 1 without line 12.


### Claims not supported by this artifact

This artifact may not support some claims of the paper. Specifically,

1. The running time and number of SMT calls may be different to Table 1 or Table 2.

2. Each conjunct synthesized by Spyro[Sketch] or Spyro[SMT] may be different to the Fig. 3, while the L-conjunctions are equivalent.


#### Reason

All the evaluation data of paper (including Table 1, 2 and Fig. 3) were generated from Apple M1 8-core CPU with 8GB RAM.
Sketch binary or SMT / SyGuS tools compiled for different architecture / OS may produce different results.


## Setup

### Requirements

Requirements of each tool can be checked in `spyro-sketch/README.md` or `spyro-smt/README.md`


## Structure of this artifact

* `dafnyProofs` contains Dafny proof files for synthesized properties of Spyro[Sketch] problems.

* `spyro-smt` contains codes and benchmarks for Spyro[SMT]. A detailed description is provided in `spyro-smt/README.md`.

* `spyro-sketch` contains codes and benchmarks for Spyro[Sketch]. A detailed description is provided in `spyro-sketch/README.md`.

* `generate_summary.py` is a script used to generate figures and summary text from execution results.

* `summary` contains figures and summary text generated by `generate_summary.py`.


## Quantitative Analysis: Performance

### Running Spyro[SMT]

Command `python3 run_benchmarks.py` in `spyro-smt` directory will run Spyro[Sketch] for every benchmark problem with three differents random seeds `[32, 64, 128]`. Running `python3 run_benchmarks.py` will take about 3 hours.

This will generate files containing synthesized properties and CSV files containing statistics in the `results` directory. For example, `smt_default_32.csv` contains statistics for seed 32, and `smt_nofreeze_128.csv` contains statistics for seed 128, executed without freezing negative examples.
It also creates files with suffix `_median`, which has median running time among three runs.

`run_benchmarks_median.py` does the same to `run_benchmarks.py`, but only run each benchmark problem with single random seed value, which generated the median value on our local machine. The output file of `run_benchmarks_median.py` will have suffix `_median`. Running `run_benchmarks_median.py` will take about 1 hour. 

Please check `spyro-spyro/README.md` for detail.

### Running Spyro[Sketch] benchmarks

Command `python3 run_benchmarks.py -a` in `spyro-sketch` directory will run Spyro[Sketch] for every benchmark problem with three differents random seeds `[32, 64, 128]`. You can execute only certain applications using the `-1`, `-2`, `-3` and `-4` arguments. For example, the command `python3 run_benchmarks_full.py -1 -3` only runs application 1 and application 3. Running `python3 run_benchmarks.py -a` will take about 2-3 days.

This will generate files containing synthesized properties and CSV files containing statistics in the `results` directory. For example, `application1_default_32.csv` contains statistics for Application 1 with seed 32, and `application3_nofreeze_128.csv` contains statistics for Application 3 with seed 128, executed without freezing negative examples.
It also creates files with suffix `_median`, which has median running time among three runs.

`run_benchmarks_median.py` does the same to `run_benchmarks.py`, but only run each benchmark problem with single random seed value, which generated the median value on our local machine. The output file of `run_benchmarks_median.py` will have suffix `_median`. Running `python run_benchmarks_median.py -a` will take less than 20 hours. 

Please check `spyro-sketch/README.md` for detail.

## Quantitative Analysis: Soundness

The Dafny binary is installed at the path `/dafny` in the docker image.
Each Dafny proof can be verified using the command `/dafny/dafny <path-to-proof-file>`.
Every proof except `dafnyProofs/list/reverse_twice.dfy` and `dafnyProofs/queue/enqueue.dfy` should succeed.

## Generating Summary

Running `python3 generate_summary.py --all` will generate figures and summary text from execution results.
You can generate only certain figure or summary text using `--figureA`, `--figureB`, `--figureC` or `--summary`.
Generated files will be stored in `summary` directory. 

To generate each figure or summary, the following conditions must be met:

* Figure A (SynthProperty vs. Grammar size)
    * Files `spyro-sketch/results/application1_default_median.csv` and `spyro-sketch/results/application1_grammer_size.csv` must exist.
    * `spyro-sketch/results/application1_default_median.csv` can be generated by running either `run_benchmarks.py` or `run_benchmarks_median.py` in the `spyro-sketch` directory with the `-a` or `-1` option.
    * `spyro-sketch/results/application1_grammer_size.csv` can be generated by running `grammar_size_calculator.py` in the `spyro-sketch` directory with the `-a` or `-1` option.

* Figure B (CheckPrecision vs. Number of examples)
    * Files `spyro-sketch/log/branch` and `spyro-sketch/log/nonLinearSum2` must exist.
    * Both files can be generated by running either `run_benchmarks.py` or `run_benchmarks_median.py` in the `spyro-sketch` directory with the `-a` or `--log` option.

* Figure C (With line 12 vs. Without line 12)
    * All files `spyro-smt/results/smt_{default | nofreeze}_median.csv` and `spyro-sketch/results/application{1 | 2 | 3 | 4}_{default | nofreeze}_median.csv` must exist
    * `spyro-smt/results/smt_{default | nofreeze}_median.csv` can be generated by running either `run_benchmarks.py` or `run_benchmarks_median.py` in the `spyro-smt` directory with the `-a` option.
    * `spyro-sketch/results/application{1 | 2 | 3 | 4}_{default | nofreeze}_median.csv` can be generated by running either `run_benchmarks_py` or `run_benchmarks_median.py` in the `spyro-sketch` directory with the `-a` option.

* Summary text
    * All files `spyro-smt/results/smt_{default | nofreeze}_median.csv` and `spyro-sketch/results/application{1 | 2 | 3 | 4}_{default | nofreeze}_median.csv` must exist
    * `spyro-smt/results/smt_{default | nofreeze}_median.csv` can be generated by running either `run_benchmarks.py` or `run_benchmarks_median.py` in the `spyro-smt` directory with the `-a` option.
    * `spyro-sketch/results/application{1 | 2 | 3 | 4}_{default | nofreeze}_median.csv` can be generated by running either `run_benchmarks_py` or `run_benchmarks_median.py` in the `spyro-sketch` directory with the `-a` option.


