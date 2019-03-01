set datafile separator ","
set terminal svg size 1000, 600 enhanced

set title font ",20"
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
