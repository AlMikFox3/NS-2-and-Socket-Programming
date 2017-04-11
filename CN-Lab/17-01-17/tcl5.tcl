set i 1
while {$i <= 10} {
puts $i
incr i
}

for {set j 1} {$j <= 10} {incr j} {
	puts $j
}
foreach color {Red Blue Green} {
	puts $color
} 

