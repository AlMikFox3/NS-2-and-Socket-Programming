#!/usr/bin/awk -f

BEGIN{
    last = 0
  
    total = 0
}
{
    if ($5 == "tcp" && $1=="r" && $4 =="2") {
     
    total += $6
    }

    #every second
    if ($2 - 1 > last) {
        last = $2
        print $2, (total*8/1000000)
       
        total = 0
    }
}
END {
    print $2, (total*8/1000000)
} 
