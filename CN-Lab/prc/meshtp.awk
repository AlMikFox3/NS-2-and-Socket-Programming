BEGIN{
	f = 0
	last = 0
}
{
	if ($5 == "tcp" && $1=="r" && $4 =="4") {
        f += $6
    }
    if ($2 - 1 > last) {
        last = $2
        print $2, (f*8/1000000)
        f = 0
    }
}
END{
	print $2, (f*8/1000000)
}