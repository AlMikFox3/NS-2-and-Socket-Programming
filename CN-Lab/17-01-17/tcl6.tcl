set i 5
for {set i 1} {$i <=5 } {incr i} {
	gets stdin j
	set A($i) $j
}
for {set i 1} {$i <=5 } {incr i} {
       puts $A($i)
}
#puts $A

