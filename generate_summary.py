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

def generateFigureA():
    pass

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

    plt.plot(xs1, ys1, color='red', label=os.path.basename(files[0]), marker='o', linestyle='None')
    plt.plot(xs2, ys2, color='blue', label=os.path.basename(files[1]), marker='x', linestyle='None')

    plt.title("CheckPrecision time vs. Number of examples")
    plt.savefig("summary/figure_b.png")

def generateFigureC():
    pass

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