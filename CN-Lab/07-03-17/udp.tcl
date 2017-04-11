set ns [new Simulator]
set nf [open "nam.out" w]
set trace [open "trace.tr" w]
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
set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set s4 [$ns node]
$ns duplex-link $s1 $s2 1.5Mb 15ms DropTail
$ns duplex-link $s2 $s3 1.5Mb 15ms DropTail
$ns duplex-link $s3 $s4 1.5Mb 15ms DropTail
$ns duplex-link $s4 $s1 1.5Mb 15ms DropTail

$ns duplex-link-op $s1 $s2 orient right-up
$ns duplex-link-op $s2 $s3 orient right-down
$ns duplex-link-op $s3 $s4 orient left-down
$ns duplex-link-op $s4 $s1 orient left-up

#Create a UDP agent and attach it to node n0
set udp0 [new Agent/UDP]
$ns attach-agent $s1 $udp0
# Create a CBR traffic source and attach it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize 500
$cbr0 set interval 0.005
$cbr0 attach-agent $udp0
#Create a Null agent (a traffic sink) and attach it to node n1
set null0 [new Agent/Null]
$ns attach-agent $s2 $null0
#Connect the traffic source with the traffic sink
$ns connect $udp0 $null0

#Create a UDP agent and attach it to node s4
set udp1 [new Agent/UDP]
$ns attach-agent $s4 $udp1
# Create a CBR traffic source and attach it to udp0
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize 500
$cbr1 set interval 0.005
$cbr1 attach-agent $udp1
#Create a Null agent (a traffic sink) and attach it to node n1
set null1 [new Agent/Null]
$ns attach-agent $s1 $null1
#Connect the traffic source with the traffic sink
$ns connect $udp1 $null1


#Create a TCP agent and attach it to node s1
set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $s2 $tcp1
$tcp1 set window 8
$tcp1 set fid 1

set tcp2 [new Agent/TCP/Reno]
$ns attach-agent $s3 $tcp2
$tcp2 set window 8
$tcp2 set fid 1

#Create TCP sink agents and attach them to node r
set sink1 [new Agent/TCPSink]
set sink2 [new Agent/TCPSink]
$ns attach-agent $s3 $sink1
$ns attach-agent $s4 $sink2
#Connect the traffic sources with the traffic sinks

$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2

#Create FTP applications and attach them to agents
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

#Schedule events for the CBR agent
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 0.5 "$cbr1 start"
$ns at 4.5 "$cbr1 stop"
$ns at 0.5 "$ftp1 start"
$ns at 4.5 "$ftp1 stop"
$ns at 0.5 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"
$ns run
