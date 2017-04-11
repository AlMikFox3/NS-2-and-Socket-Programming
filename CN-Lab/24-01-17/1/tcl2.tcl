set ns [new Simulator]
set nf [open "nam.out" w]
set trace [open "trace.tr" w]
set cwndTrace [open "cwnd.tr" w]
$ns namtrace-all $nf
$ns trace-all $trace

Agent/TCP set window_ 50

proc finish {} {
	global nf trace ns
	$ns flush-trace
	close $nf
	close $trace

	puts "Simulation_complete"; exit 1
}

proc record {} {
	global tcpSender1 tcpSender2 ns cwndTrace

	$ns at [expr [$ns now] + 0.6] "record"
	set cwnd1 [$tcpSender1 set cwnd_]
	set cwnd2 [$tcpSender2 set cwnd_]
	puts $cwndTrace "[$ns now] $cwnd1 $cwnd2"
} 

set s1 [$ns node]
set s2 [$ns node]
set router [$ns node]
set d [$ns node]

$ns duplex-link $s1 $router 1.5Mb 15ms DropTail
$ns duplex-link $s2 $router 1.5Mb 15ms DropTail
$ns duplex-link $router $d 2Mb 15ms DropTail
set tcpSender1 [$ns create-connection "TCP/Reno" $s1 "TCPSink" $d 0]
set tcpSender2 [$ns create-connection "TCP/Reno" $s2 "TCPSink" $d 1]


set ftpSender1 [new Application/FTP]
$ftpSender1 attach-agent $tcpSender1



set ftpSender2 [new Application/FTP]
$ftpSender2 attach-agent $tcpSender2


$ns at 0.0 "$ftpSender1 start"
$ns at 0.0 "$ftpSender2 start"
$ns at 0.0 "record"
$ns at 25 "finish"
$ns run
