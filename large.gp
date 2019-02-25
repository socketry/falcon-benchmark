set datafile separator ","
set terminal svg size 800, 600 enhanced; set key left above
plot 'large.txt' using 1:2 with lines title "wrk -s output.lua -c $x -t $x -d 1 http://falcon/large",'large.txt' using 1:4 with lines title "wrk -s output.lua -c $x -t $x -d 1 http://passenger/large"
