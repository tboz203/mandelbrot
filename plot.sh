#!/bin/bash
filename="gnuplot.$$.tmp"
gnuplot -p > "$filename" <<EOF
set terminal png size 1000,1000
set palette model RGB defined (0 '#0000FF', 1 '#2222FF', 2 '#4444FF', 3 '#6666FF', 6 '#FFFFFF')
plot 'output' using 1:2:3 with points palette
EOF

if [[ -z $1 ]]; then
    mv "$filename" "mandelbrot.png"
else
    mv "$filename" "$1"
fi
