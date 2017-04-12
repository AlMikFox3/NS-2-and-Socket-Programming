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
set s4 [$ns node]
set s5 [$ns node]
set s6 [$ns node]
set s7 [$ns node]
set s8 [$ns node]
set s9 [$ns node]

$ns duplex-link $s1 $s2 2Mb 20ms DropTail
$ns duplex-link $s3 $s4 2Mb 20ms DropTail
$ns duplex-link $s2 $s3 2Mb 20ms DropTail
$ns duplex-link $s2 $s5 2Mb 20ms DropTail
$ns duplex-link $s2 $s6 2Mb 20ms DropTail
$ns duplex-link $s5 $s4 2Mb 20ms DropTail
$ns duplex-link $s5 $s8 2Mb 20ms DropTail
$ns duplex-link $s5 $s6 2Mb 20ms DropTail
$ns duplex-link $s4 $s8 2Mb 20ms DropTail
$ns duplex-link $s8 $s9 2Mb 20ms DropTail
$ns duplex-link $s6 $s7 2Mb 20ms DropTail
$ns duplex-link $s7 $s8 2Mb 20ms DropTail

$ns duplex-link-op $s1 $s2 orient down
$ns duplex-link-op $s2 $s3 orient left-down
$ns duplex-link-op $s2 $s5 orient right-down
$ns duplex-link-op $s2 $s6 orient right
$ns duplex-link-op $s5 $s4 orient left-down
$ns duplex-link-op $s5 $s8 orient right-down
$ns duplex-link-op $s5 $s6 orient right-up
$ns duplex-link-op $s4 $s8 orient right
$ns duplex-link-op $s8 $s9 orient down
$ns duplex-link-op $s6 $s7 orient right-down
$ns duplex-link-op $s7 $s8 orient left-down
$ns duplex-link-op $s3 $s4 orient right-down

$ns at 0.0 "$s1 label n1"
$ns at 0.0 "$s2 label n2"
$ns at 0.0 "$s3 label n3"
$ns at 0.0 "$s4 label n4"
$ns at 0.0 "$s5 label n5"
$ns at 0.0 "$s6 label n6"
$ns at 0.0 "$s7 label n7"
$ns at 0.0 "$s8 label n8"
$ns at 0.0 "$s9 label n9"


set tcpsen1 [$ns create-connection "TCP/Reno" $s1 "TCPSink" $s9 0]
#set tcpsen2 [$ns create-connection "TCP/Reno" $s2 "TCPSink" $d1 1]
#set tcpsen3 [$ns create-connection "TCP/Reno" $s3 "TCPSink" $d1 2]

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcpsen1

set udp1 [new Agent/UDP]
$ns attach-agent $s3 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize 500
$cbr1 set interval 0.005
$cbr1 attach-agent $udp1

set null1 [new Agent/Null]
$ns attach-agent $s7 $null1

$ns connect $udp1 $null1

#set ftp2 [new Application/FTP]
#$ftp2 attach-agent $tcpsen2

#set ftp3 [new Application/FTP]
#$ftp3 attach-agent $tcpsen3

$ns at 2.0 "$ftp1 start"
$ns at 98.0 "$ftp1 stop"
$ns at 1.0 "$cbr1 start"
$ns at 99.0 "$cbr1 stop"
#$ns at 0.0 "$ftp2 start"
#$ns at 0.0 "$ftp3 start"
$ns at 100 "finish"
$ns run