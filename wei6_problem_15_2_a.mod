 set INTER;  # intersections
 param entr symbolic in INTER;           # entrance to road network
 param exit symbolic in INTER, <> entr;  # exit from road network
 set ROADS within (INTER diff {exit}) cross (INTER diff {entr});
 param length {ROADS} >= 0;         # lengths to travel roads
 var Use {(i,j) in ROADS} >= 0;   # 1 iff (i,j) in shortest path
 minimize Total_length: sum {(i,j) in ROADS} length[i,j] * Use[i,j];
 subject to Start:  sum {(entr,j) in ROADS} Use[entr,j] = 1;
 subject to Balance {k in INTER diff {entr,exit}}:
 sum {(i,k) in ROADS} Use[i,k] = sum {(k,j) in ROADS} Use[k,j];

 #The shortest path found by ampl is 31 