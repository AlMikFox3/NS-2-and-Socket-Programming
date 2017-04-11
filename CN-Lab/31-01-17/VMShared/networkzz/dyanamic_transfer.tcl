# Filename: test3.tcl

# —————-ESTABLISHING COMMUNICATION ————-#

#————–TCP CONNECTION BETWEEN NODES—————#

proc Tranmission {} {
global C ROU R ns

set now [$ns now]
set time 0.75
set x [expr round(rand()*4)];if {$x==0} {set x 2}
set y [expr round(rand()*4)];if {$y==0} {set y 3}

set tcp1 [$ns create-connection TCP $C($x) TCPSink $R($y) 1]
$ns at $now "$ns trace-annotate \"Time: $now Pkt Transfer between Client($x) Receiver($y)..\""
$tcp1 set class_ 1
$tcp1 set maxcwnd_ 16
$tcp1 set packetsize_ 4000
$tcp1 set fid_ 1
set ftp1 [$tcp1 attach-app FTP]
$ftp1 set interval_ .005
$ns at $now "$ftp1 start"
$ns at [expr $now+$time] "$ftp1 stop"
$ns at [expr $now+$time] "Tranmission"
}