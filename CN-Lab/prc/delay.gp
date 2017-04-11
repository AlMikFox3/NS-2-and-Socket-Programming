set term postscript eps enhanced color
set title "Delay"
set xlabel "Time (s)"
set ylabel "Delay"
set output "delay.eps"

plot "output.tr" using 1:2 title "Delay" with linespoints 
