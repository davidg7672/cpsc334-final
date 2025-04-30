#!/bin/sh

PROGRAM_NAME=merge_sort

cd bin
g++ -std=c++11 -Wall -O main.cpp linkedlist.cpp -o main
./main

echo "Successfully built and compiled in C++"