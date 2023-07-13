import os
import sys
import numpy as np
import shutil
import statistics
import matplotlib.pyplot as plt
import argparse
from enum import Enum

class Columns(Enum):
    BENCHMARK_NAME = 1
    NUM_CONJUNCT = 2
    NUM_SYNTH_CALL = 3
    TIME_SYNTH_CALL = 4
    NUM_SOUNDNESS_CALL = 5
    TIME_SOUNDNESS_CALL = 6
    NUM_PRECISION_CALL = 7
    TIME_PRECISION_CALL = 8
    TIME_LAST_CALL = 9
    TIME_LIST_ITER = 10
    TIME_TOTAL = 11

def grammarSize():
    files = [f"spyro-sketch/results/application1_grammar_size.csv"]
    ret = []

    for filename in files:
        with open(filename, "r") as f:
            lines = f.readlines()

        for line in lines:
            line = line.split(",")

            if len(line) < 1:
                break
            
            ret.append(int(line[1]))
    
    return ret

def synthPropertyTime():
    files = [f"spyro-sketch/results/application1_default_median.csv"]
    ret = []

    for filename in files:
        with open(filename, "r") as f:
            lines = f.readlines()

        for line in lines[1:]:
            line = line.split(",")

            if len(line) < 1:
                break
            
            totalTime = float(line[-1])
            numConjunct = float(line[1])
            ret.append(totalTime / numConjunct)
    
    return ret

def generateFigureA():
    xs = grammarSize()
    ys = synthPropertyTime()

    fig, ax = plt.subplots()

    ax.plot(xs[:9], ys[:9], color='red', label='SyGuS', marker='o', linestyle='None')
    ax.plot(xs[9:34], ys[9:34], color='blue', label='Synquid', marker='x', linestyle='None')
    ax.plot(xs[34:], ys[34:], color='green', label='Others', marker='*', linestyle='None')

    ax.set_xscale("log")
    ax.set_yscale("log")

    ax.set_title("SynthProperty time vs. Grammar size")
    ax.set_xlabel("Grammar size")
    ax.set_ylabel("SynthProperty")
    ax.legend(loc="lower right")
    fig.savefig("summary/figure_a.png")

    plt.close(fig)

def logToPlots(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    xs = []
    ys = []

    for line in lines:
        line = line.split(',')
        
        if len(line) < 1:
            break

        if line[2] != 'P':
            continue

        npos = int(line[4])
        nnegmust = int(line[5])
        nnegmay = int(line[6])
        time = float(line[3])

        xs.append(npos + nnegmust + nnegmay)
        ys.append(time)

    return xs, ys

def generateFigureB():
    files = ["spyro-sketch/log/nonLinearSum2", "spyro-sketch/log/branch"]

    xs1, ys1 = logToPlots(files[0])
    xs2, ys2 = logToPlots(files[1])

    fig, ax = plt.subplots()

    ax.plot(xs1, ys1, color='red', label=os.path.basename(files[0]), marker='o', linestyle='None')
    ax.plot(xs2, ys2, color='blue', label=os.path.basename(files[1]), marker='x', linestyle='None')

    ax.set_title("CheckPrecision time vs. Number of examples")
    ax.set_xlabel("# examples")
    ax.set_ylabel("CheckPrecision")

    fig.savefig("summary/figure_b.png")

def generateFigureC():
    files = [
        "spyro-smt/results/smt",
        "spyro-sketch/results/application1",
        "spyro-sketch/results/application2",
        "spyro-sketch/results/application3",
        "spyro-sketch/results/application4"
    ]

    defaults = []
    for filename in files:
        path = f"{filename}_default_median.csv"

        with open(path, "r") as f:
            lines = f.readlines()
        
        for line in lines[1:]:
            line = line.split(',')

            if len(line) < 1:
                break
        
            defaults.append(float(line[-1]))

    nofreezes = []
    for filename in files:
        path = f"{filename}_nofreeze_median.csv"

        with open(path, "r") as f:
            lines = f.readlines()
        
        for line in lines[1:]:
            line = line.split(',')

            if len(line) < 1:
                break
        
            nofreezes.append(float(line[-1]))

    fig, ax = plt.subplots()

    top = max(nofreezes + defaults)

    ax.plot(nofreezes, defaults, color='black', marker='o', linestyle='None')
    ax.plot([1, top], [1, top], color='blue')

    ax.set_xscale("log")
    ax.set_yscale("log")

    ax.set_title("With line 12 vs. Without line 12")
    ax.set_xlabel("Without line 12")
    ax.set_ylabel("With line 12")
    fig.savefig("summary/figure_c.png")

def generateSummary():
    pass

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--all', '-a', dest='all', action='store_true', default=False)
    parser.add_argument('--figureA', dest='figure_a', action='store_true', default=False)
    parser.add_argument('--figureB', dest='figure_b', action='store_true', default=False)
    parser.add_argument('--figureC', dest='figure_c', action='store_true', default=False)
    parser.add_argument('--summary', dest='summary', action='store_true', default=False)

    args = parser.parse_args(sys.argv[1:])   

    figure_a = args.figure_a or args.all
    figure_b = args.figure_b or args.all
    figure_c = args.figure_c or args.all
    summary = args.summary or args.all

    os.makedirs("summary", exist_ok=True)

    if figure_a:
        generateFigureA()
    
    if figure_b:
        generateFigureB()
    
    if figure_c:
        generateFigureC()
    
    if summary:
        generateSummary()

if __name__=="__main__":
    main()