#!/usr/bin/awk -f

BEGIN{
    last = 0
    f1 = 0
    f2 = 0
    total = 0
}
{
    if ($5 == "tcp" && $1=="r" && $4 =="3") {
        if ($8 == "0") {
        f1 += $6
    }
    if ($8 == "1") {
        f2 += $6
    }
    total += $6
    }

    #every second
    if ($2 - 1 > last) {
        last = $2
        print $2, (f1*8/1000000), (f2*8/1000000), (total*8/1000000)
        f1 = 0
        f2 = 0
        total = 0
    }
}
END {
    print $2, (f1*8/1000000), (f2*8/1000000), (total*8/1000000)
} 
