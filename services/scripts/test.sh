#!/bin/sh

PROGRAM_NAME=merge_sort

cd bin
curl -o doctest.h https://raw.githubusercontent.com/doctest/doctest/master/doctest/doctest.h
g++ -std=c++11 -Wall -O linkedlist.cpp test.cpp -o test
./test

echo "Built test in C++"
