#!/bin/bash

# This script was written to sum all the PDOS for each orbital for all the uranium atoms in the system (32 in total). 
# Columns for 1st paste command: energy, s, -s, p, -p, d, -d, f, -f, energy, s, -s, p, -p, d, -d, f, -f
# Output data from the first paste command: energy, s, -s, p, -p, d, -d, f, -f
# Columns for 1st paste command: energy, s, -s, p, -p, d, -d, f, -f, energy, s, -s, p, -p, d, -d, f, -f
# Output data from the second paste command: energy, s, -s, p, -p, d, -d, f, -f
# In the final output file, subtract the fermi energy (8.2231 in this script) from each energy value in column 1.
# The fermi value can be found in the OUTCAR file.

for ((i=65; i<=65q; i++)); do
    m=$(($i-1))
    paste DOS.tmp$m DOS.tmp$i | awk '{printf "%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f \n", $1, $2+$11, $3+$12, $4+$13, $5+$14, $6+$15, $7+$16, $8+$17, $9+$18}' >| DOS_U.tmp

done

for ((i=66; i<=96; i++)); do
    paste DOS.tmp$i DOS_U.tmp | awk '{printf "%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f \n", $1, $2+$11, $3+$12, $4+$13, $5+$14, $6+$15, $7+$16, $8+$17, $9+$18}' >| DOS_U.tmp2 && mv DOS_U.tmp2 DOS_U.tmp

done

mv DOS_U.tmp DOS_Uranium.dat

awk '{print ($1 - 8.2231) " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}' DOS_Uranium.dat >| DOS_U.test && mv DOS_U.test DOS_Uranium.dat
