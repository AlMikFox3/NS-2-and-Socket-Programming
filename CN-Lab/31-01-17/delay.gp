set term postscript eps enhanced color
set title "Delay"
set xlabel "Time (s)"
set ylabel "Delay"
set output "Delay.eps"

plot "output.tr" using 1:2 title "Flow 1" with linespoints 