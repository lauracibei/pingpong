#! /bin/bash
# Expect protocol name as first parameter (tcp or udp)

# Define input and output file names
ThroughFile="../data/$1_throughput.dat";
PngName="../data/LB$1.png";

#getting the first and the last line of the file
HeadLine=($(head $ThroughFile --lines=1))
TailLine=($(tail $ThroughFile --lines=1))

#getting the information from the first and the last line
# TO BE DONE START
N1=${HeadLine[0]}
TN1=${HeadLine[1]}
N2=${TailLine[0]}
TN2=${TailLine[1]}

D1=$(echo "scale=9; $N1 / $TN1" | bc -l)
D2=$(echo "scale=9; $N2 / $TN2" | bc -l)

Band=$(echo "scale=9; ($N2 - $N1) / ($D2 - $D1)" | bc -l)
Latency=$(echo "scale=9; ($D1 * $N2 - $D2 * $N1) / ($N2 - $N1)" | bc -l)
# TO BE DONE END


# Plotting the results
gnuplot <<-eNDgNUPLOTcOMMAND
	set term png size 900, 700
	set output "${PngName}"
	set logscale x 2
	set logscale y 10
	set xlabel "msg size (B)"
	set ylabel "throughput (KB/s)"
	set xrange[$FirstN:$LastN]
	lbmodel(x)= x / ($Latency + (x/$Band))

# TO BE DONE START
	plot "${ThroughFile}" using 1:2 title "median throughput" with linespoints, \
		lbmodel(x) title "$1 Latency-Bandwidth model with L=$Latency and B=$Band" with linespoints
# TO BE DONE END

  clear

eNDgNUPLOTcOMMAND
