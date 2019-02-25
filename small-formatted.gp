set datafile separator ","
set terminal svg size 800, 600 enhanced; set key left above

set ytics nomirror
set y2tics

set style line 1 lt 2 lc rgb "green" lw 3
set style line 2 lt 2 lc rgb "green" lw 1 dt 2
set style line 3 lt 2 lc rgb "blue" lw 3 
set style line 4 lt 2 lc rgb "blue" lw 1 dt 2

plot \
	'small.txt' using 1:2 with lines title "http://falcon/small" axis x1y1 ls 1, \
	'small.txt' using 1:3 with lines title "falcon latency (ms)" axis x1y2 ls 2, \
	'small.txt' using 1:4 with lines title "http://passenger/small" axis x1y1 ls 3, \
	'small.txt' using 1:5 with lines title "passenger latency (ms)" axis x1y2 ls 4
