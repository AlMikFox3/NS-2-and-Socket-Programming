set a "10 + 1"
puts $a
set b 5
puts $b
set c $a$b
puts $c
set d [expr $a + $b]
puts $d
set var "10 + 1 - 3 * 5"
puts [expr $var]
