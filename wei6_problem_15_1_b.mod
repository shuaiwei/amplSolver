set CITIES;
set LINKS within (CITIES cross CITIES);
param supply {CITIES} >= 0;   # amounts available at cities
param demand {CITIES} >= 0;   # amounts required at cities
   check: sum {i in CITIES} supply[i] = sum {j in CITIES} demand[j];
param cost {LINKS} >= 0;      # shipment costs
param capacity {LINKS} >= 0;  # max packages that can be shipped
minimize Total_Cost;
node Balance {k in CITIES}: net_in = demand[k] - supply[k];
arc Ship {(i,j) in LINKS} >= 0, <= capacity[i,j],
   from Balance[i], to Balance[j], obj Total_Cost cost[i,j];


############
# Answer questions of 15-1(b);
# Yes,the solver appear to be using the same algorithm as in (a);
############

##############
# Use fomulation from (a)

# LP_SOLVE 4.0.1.0: optimal, objective 3710
# 9 simplex iterations

# CPLEX 12.6.0.0: optimal solution; objective 3710
# 2 dual simplex iterations (1 in phase I)

# Gurobi 5.6.3: optimal solution; objective 3710
# 5 simplex iterations

# XPRESS 25.01: Optimal solution found
# Objective 3710
# 1 simplex iteration
##############

##############
# Use formualtion from (b)

# LP_SOLVE 4.0.1.0: optimal, objective 3710
# 9 simplex iterations

# CPLEX 12.6.0.0: optimal solution; objective 3710
# 8 network simplex iterations.
# 0 simplex iterations (0 in phase I)

# Gurobi 5.6.3: optimal solution; objective 3710
# 5 simplex iterations

# XPRESS 25.01: Optimal solution found
# Objective 3710
# 1 simplex iteration

###############