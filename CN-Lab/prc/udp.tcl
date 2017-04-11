set ns [new Simulator]
set trace [open "traceudp.tr" w]
set nf [open "nam.out" w]
$ns trace-all $trace
$ns namtrace-all $nf

Agent/TCP set window_ 50

proc finish {} {
	global ns nf trace
	$ns flush-trace
	close $nf
	close $trace
	puts "Done Simulating"
	exit 1
}

set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set s4 [$ns node]

$ns duplex-link $s1 $s2 1.5Mb 10ms DropTail
$ns duplex-link $s2 $s3 1.5Mb 10ms DropTail
$ns duplex-link $s3 $s4 1.5Mb 10ms DropTail
$ns duplex-link $s4 $s1 1.5Mb 10ms DropTail

$ns duplex-link-op $s1 $s2 orient right-up
$ns duplex-link-op $s2 $s3 orient right-down
$ns duplex-link-op $s3 $s4 orient left-down
$ns duplex-link-op $s4 $s1 orient left-up

set udp1 [new Agent/UDP]
$ns attach-agent $s1 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize 500
$cbr1 set interval 0.005
$cbr1 attach-agent $udp1

set null1 [new Agent/Null]
$ns attach-agent $s2 $null1

$ns connect $udp1 $null1

set udp2 [new Agent/UDP]
$ns attach-agent $s4 $udp2

set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize 500
$cbr2 set interval 0.005
$cbr2 attach-agent $udp2

set null2 [new Agent/Null]
$ns attach-agent $s1 $null2

$ns connect $udp2 $null2

set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $s2 $tcp1
$tcp1 set window 8
$tcp1 set fid 1

set tcp2 [new Agent/TCP/Reno]
$ns attach-agent $s1 $tcp2
$tcp2 set window 8
$tcp2 set fid 1

set sink1 [new Agent/TCPSink]
$ns attach-agent $s3 $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $s2 $sink2

$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$ns at 0.5 "$cbr1 start"
$ns at 4.5 "$cbr1 stop"
$ns at 0.5 "$cbr2 start"
$ns at 4.5 "$cbr2 stop"
$ns at 0.5 "$ftp1 start"
$ns at 4.5 "$ftp1 stop"
$ns at 0.5 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5 "finish"
$ns run