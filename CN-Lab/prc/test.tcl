set ns [new Simulator]
set nf [open "nam.out" w]
set trace [open "trace.tr" w]
$ns namtrace-all $nf
$ns trace-all $trace

Agent/TCP set window_ 50

proc finish {} {
	global ns trace nf
	$ns flush-trace
	close $trace
	close $nf
	puts "Done Simulating";
	exit 1
}

set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set d1 [$ns node]

$ns duplex-link $s1 $s3 1.5Mb 30ms DropTail
$ns duplex-link $s2 $s3 1.5Mb 30ms DropTail
$ns duplex-link $s3 $d1 2Mb 10ms DropTail

set tcpsen1 [$ns create-connection "TCP/Reno" $s1 "TCPSink" $d1 0]
set tcpsen2 [$ns create-connection "TCP/Reno" $s2 "TCPSink" $d1 1]
set tcpsen3 [$ns create-connection "TCP/Reno" $s3 "TCPSink" $d1 2]

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcpsen1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcpsen2

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcpsen3

$ns at 0.0 "$ftp1 start"
$ns at 0.0 "$ftp2 start"
$ns at 0.0 "$ftp3 start"
$ns at 25 "finish"
$ns run