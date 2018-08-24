#!/bin/bash

# Use this script to calculate the total density of states. The values in this script are associated with a 96 atom system.
# Columns for 1st paste command: energy, s, -s, p, -p, d, -d, f, -f, energy, s, -s, p, -p, d, -d, f, -f
# Output data from the first paste command: energy, spin up, spin down
# Columns for 2nd paste command: energy, s, -s, p, -p, d, -d, f, -f, energy, spin up, spin down
# Output data from the second paste command: energy, spin up, spin down

n=2
m=$(($n-1))
paste DOS.tmp$m DOS.tmp$n | awk '{printf "%12.8f %12.8f %12.8f \n", $1, $2+$4+$6+$8+$11+$13+$15+$17, $3+$5+$7+$9+$12+$14+$16+$18}' >| DOS_all.tmp

for ((i=3; i<=96; i++)); do
    paste DOS.tmp$i DOS_all.tmp | awk '{printf "%12.8f %12.8f %12.8f \n", $1, $2+$4+$6+$8+$11, $3+$5+$7+$9+$12}' >| DOS_all.tmp2 && mv DOS_all.tmp2 DOS_all.tmp

done

mv DOS_all.tmp DOS_all.dat

awk '{printf "%12.8f %12.8f %12.8f \n", ($1 - 8.2231), $2, $3}' DOS_all.dat >| DOS_all.test && mv DOS_all.test DOS_all.dat
