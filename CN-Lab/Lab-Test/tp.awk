#!/usr/bin/awk -f

BEGIN{
    last = 0
    f1 = 0
    total = 0
    ack = 0
}
{
    if ($5 == "tcp" && $1=="r" && $4 =="8") {
        if ($8 == "0") {
        f1 += $6
    }
   
   
    total += $6
    }
    if ($5 == "ack") {
        ack += 1}
    #every second
    if ($2 - 1 > last) {
        last = $2
        print $2, (f1*8/1000000), (total*8/1000000), ack
        f1 = 0
        total = 0
    }
}
END {
    print $2, (f1*8/1000000), (total*8/1000000), ack
} 
