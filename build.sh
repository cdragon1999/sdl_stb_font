#!/bin/bash
echo "Building example.cpp => ./example ..."
g++ example.cpp -std=c++17 -O2 -g  -o example `sdl2-config --cflags --libs` && \
echo "Done!"
