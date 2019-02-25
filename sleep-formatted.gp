set datafile separator ","
set terminal svg size 800, 600 enhanced

set key left above

set xlabel "Concurrency (connections)"
set xrange [1:384]
set xtics 0, 32, 512

set ylabel "Requests Per Second"
set ytics nomirror

set y2label "Latency (ms)"
set y2tics

set style line 1 lt 2 lc rgb "green" lw 3
set style line 2 lt 2 lc rgb "green" lw 1 dt 2
set style line 3 lt 2 lc rgb "blue" lw 3 
set style line 4 lt 2 lc rgb "blue" lw 1 dt 2
set style line 5 lt 2 lc rgb "orange" lw 2 
set style line 6 lt 2 lc rgb "red" lw 2

plot \
	'sleep.txt' using 1:2 with lines title "falcon requests" axis x1y1 ls 1, \
	'sleep.txt' using 1:3 with lines title "falcon latency" axis x1y2 ls 2, \
	'sleep.txt' using 1:5 with lines title "passenger requests" axis x1y1 ls 3, \
	'sleep.txt' using 1:6 with lines title "passenger latency" axis x1y2 ls 4, \
	'sleep.txt' using 1:4 with lines title "falcon errors" axis x1y1 ls 5, \
	'sleep.txt' using 1:7 with lines title "passenger errors" axis x1y1 ls 6
