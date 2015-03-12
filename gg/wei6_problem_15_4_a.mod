set STUDENTS;
set PROJECTS;
param RANK {STUDENTS,PROJECTS} >=1, <=7;

var stuPro {STUDENTS,PROJECTS} integer >=0, <=1;

minimize Total_Rank:
   sum {i in STUDENTS, j in PROJECTS} RANK[i,j] * stuPro[i,j];

subject to BlaStu {i in STUDENTS}:  
   sum {j in PROJECTS} stuPro[i,j] = 1;
subject to BlaPro {j in PROJECTS}:  
   3 <= sum {i in STUDENTS} stuPro[i,j] <=4;
subject to BlaMatch:  
   sum {i in STUDENTS, j in PROJECTS} stuPro[i,j] = 28;