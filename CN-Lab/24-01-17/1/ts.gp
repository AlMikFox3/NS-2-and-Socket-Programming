set term postscript eps enhanced color
set title "Congestion Window"
set xlabel "Time (s)"
set ylabel "CWND(packets)"
set output "cp.eps"

plot "cwnd.tr" using 1:2 title "Flow 1" with linespoints ,\
"cwnd.tr" using 1:3 title "Flow 2" with linespoints