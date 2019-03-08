
load 'general.gp'

set terminal qt size 1920, 1080 enhanced

set title "Small Response (1200 bytes)"
datafile = 'small.csv'

load 'plot.gp'

pause 8
reread
