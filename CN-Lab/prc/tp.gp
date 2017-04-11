set term postscript eps enhanced color
set title "Throughput"
set xlabel "Time (s)"
set ylabel "Throughput (Mbps)"
set output "tp.eps"

plot "tp.tr" using 1:2 title "Delay" with linespoints ,\
"tp.tr" using 1:3 title "Flow 2" with linespoints,\
"tp.tr" using 1:4 title "Flow 3" with linespoints,\
"tp.tr" using 1:5 title "Total" with linespoints
