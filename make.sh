#!/usr/bin/env bash
cat data |awk -f conv1.awk >  run.ml
cat data |awk -f coord.awk >> coord.txt
cat data |awk -f conv2.awk >> run.ml
cat solve.ml >> run.ml

