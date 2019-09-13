
plot \
	datafile using 1:2 with lines title "falcon requests" axis x1y1 ls 1, \
	datafile using 1:3 with lines title "falcon latency" axis x1y2 ls 2, \
	datafile using 1:($4 == 0 ? NaN : $4) with linespoints title "falcon errors" axis x1y1 ls 3, \
	datafile using 1:5 with lines title "nginx+passenger requests" axis x1y1 ls 4, \
	datafile using 1:6 with lines title "nginx+passenger latency" axis x1y2 ls 5, \
	datafile using 1:($7 == 0 ? NaN : $7) with linespoints title "nginx+passenger errors" axis x1y1 ls 6, \
	datafile using 1:8 with lines title "passenger requests" axis x1y1 ls 7, \
	datafile using 1:9 with lines title "passenger latency" axis x1y2 ls 8, \
	datafile using 1:($10 == 0 ? NaN : $10) with linespoints title "passenger errors" axis x1y1 ls 9, \
	datafile using 1:11 with lines title "puma requests" axis x1y1 ls 10, \
	datafile using 1:12 with lines title "puma latency" axis x1y2 ls 11, \
	datafile using 1:($13 == 0 ? NaN : $13) with linespoints title "puma errors" axis x1y1 ls 12, \
	datafile using 1:14 with lines title "unicorn requests" axis x1y1 ls 13, \
	datafile using 1:15 with lines title "unicorn latency" axis x1y2 ls 14, \
	datafile using 1:($16 == 0 ? NaN : $16) with linespoints title "unicorn errors" axis x1y1 ls 15