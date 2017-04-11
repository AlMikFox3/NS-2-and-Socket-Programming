set infile [ open "lol.txt" r]
set number 0


while { [gets $infile line ] >= 0 } {
    incr number
}


close $infile

puts "Number of lines $number"





