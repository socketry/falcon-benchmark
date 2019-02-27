set datafile separator ","
set terminal svg size 1000, 600 enhanced

set title "Slow Upstream (simulated)" font ",20"
set key below right font ",10" height 2

set xlabel "Concurrency (connections)"
set xrange [1:512]
set xtics 0, 32, 512

set ylabel "Requests (per second)"
set ytics nomirror

set y2label "Latency (ms)"
set y2tics

set style line 1 lt 2 lc rgb "#94c46b" lw 3
set style line 2 lt 2 lc rgb "#94c46b" lw 1 dt 2
set style line 3 lt 2 lc rgb "red" lw 1 pt "⒜" pi -1 ps 1.5
set style line 4 lt 2 lc rgb "#c674c2" lw 3
set style line 5 lt 2 lc rgb "#c674c2" lw 1 dt 2
set style line 6 lt 2 lc rgb "red" lw 1 pt "⒝" pi -1 ps 1.5
set style line 7 lt 2 lc rgb "#d57f50" lw 3
set style line 8 lt 2 lc rgb "#d57f50" lw 1 dt 2
set style line 9 lt 2 lc rgb "red" lw 1 pt "⒞" pi -1 ps 1.5
set style line 10 lt 2 lc rgb "#60aed6" lw 3
set style line 11 lt 2 lc rgb "#60aed6" lw 1 dt 2
set style line 12 lt 2 lc rgb "red" lw 1 pt "⒟" pi -1 ps 1.5

plot \
	'sleep.csv' using 1:2 with lines title "falcon requests" axis x1y1 ls 1, \
	'sleep.csv' using 1:3 with lines title "falcon latency" axis x1y2 ls 2, \
	'sleep.csv' using 1:($4 == 0 ? NaN : $4) with linespoints title "falcon errors" axis x1y1 ls 3, \
	'sleep.csv' using 1:5 with lines title "nginx+passenger requests" axis x1y1 ls 4, \
	'sleep.csv' using 1:6 with lines title "nginx+passenger latency" axis x1y2 ls 5, \
	'sleep.csv' using 1:($7 == 0 ? NaN : $7) with linespoints title "nginx+passenger errors" axis x1y1 ls 6, \
	'sleep.csv' using 1:8 with lines title "passenger requests" axis x1y1 ls 7, \
	'sleep.csv' using 1:9 with lines title "passenger latency" axis x1y2 ls 8, \
	'sleep.csv' using 1:($10 == 0 ? NaN : $10) with linespoints title "passenger errors" axis x1y1 ls 9, \
	'sleep.csv' using 1:11 with lines title "puma requests" axis x1y1 ls 10, \
	'sleep.csv' using 1:12 with lines title "puma latency" axis x1y2 ls 11, \
	'sleep.csv' using 1:($13 == 0 ? NaN : $13) with linespoints title "puma errors" axis x1y1 ls 12