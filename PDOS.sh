#!/bin/bash

# This script separates all the atoms into separate data files. Keep in mind this script was written for a 96 atom UO2 supercell.
# Columns in VASP DOSCAR file with f-orbitals:
# energy, s, -s, py, -py, pz, -pz, px, -px, dxy, -dxy, dyz, -dyz, dz2, -dz2, dxz, -dxz, dx2-y2, -dx2-y2, fy3x2, -fy3x2, fxyz, -fxyz, fyz2, -fyz2, fz3, -fz3, fxz2, -fxz2, fzx2, -fzx2, fx3, -fx3

# number of lines of interest
nl=$(wc -l DOSCAR | sed '308s/://g' | awk '{print $1}') 
echo $nl

# %12.8f format to 8 decimal places but the whole string is 12 characters
# Output data files contain the following columns: energy, s, -s, p, -p, d, -d, f, -f
for ((i=1; i<=96; i++)); do
    
    start=$(($i*301 + 6 + $i))
    # echo $start
    end=$(($i*301 + 307 + $i))
    # echo $end
    
    sed -n ''$start','$end' p' DOSCAR | awk '{printf "%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f %12.8f \n", $1, $2, ($3 * -1.0), $4+$6+$8, (($5+$7+$9) * -1.0), $10+$12+$14+$16+$18, (($11+$13+$15+$17+$19) * -1.0), $20+$22+$24+$26+$28+$30+$32, (($21+$23+$25+$27+$29+$31+$33) * -1.0)}' >| DOS.tmp 
    tail -n300 DOS.tmp | awk '{print}' > DOS.tmp$i && rm DOS.tmp
done

