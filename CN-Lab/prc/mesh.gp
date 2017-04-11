set term postscript eps enhanced color
set title "Throughput"
set xlabel "Time (s)"
set ylabel "Throughput (Mbps)"
set output "meshtp.eps"

plot "meshtr.tr" using 1:2 title "Flow 1" with linespoints ,\

