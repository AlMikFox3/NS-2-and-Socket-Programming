set ns [new Simulator]
set nt [open test2.tr w]
$ns trace-all $nt
set nf [open test2.nam w]
$ns namtrace-all $nf
$ns color 1 darkmagenta
$ns color 2 yellow
$ns color 3 blue
$ns color 4 green
$ns color 5 black
set totalNodes 3
for { set i 0 } { $i < $totalNodes } { incr i } {
set node_($i) [$ns node]
} 
set server 0
set router 1
set client 2
$ns duplex-link $node_($server) $node_($router) 2Mb 50ms DropTail
$ns duplex-link $node_($router) $node_($client) 2Mb 50ms DropTail
$ns duplex-link-op $node_($server) $node_($router) orient right
$ns duplex-link-op $node_($router) $node_($client) orient right
$ns at 0.0 " $node_($server) label Server "
$ns at 0.0 " $node_($router) label Router "
$ns at 0.0 " $node_($client) label Client "
$ns at 0.0 " $node_($server) color blue "
$ns at 0.0 " $node_($client) color blue "
$node_($server)  shape hexagon
$node_($client) shape hexagon
set tcp [new Agent/TCP]
$ns attach-agent $node_($server) $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $node_($client) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$tcp set fid_ 4
$ns at 1.0 "$ftp start"
$ns at 6.0 "$ftp stop"
proc finish {} {
global ns nf nt
$ns flush-trace
close $nf
close $nt
puts "running nam..."
exec nam test2.nam & 
exit 0
}
$ns at 10.0 "finish"
$ns run
