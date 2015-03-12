set D_CITY;
set W_CITY;
set DW_LINKS within (D_CITY cross W_CITY);
param T > 0; # number of weeks
param inv0 {D_CITY} >= 0; # initial inventory
var Inv {D_CITY,0..T} >= 0; # tons inventoried
param invcost {D_CITY} >= 0; # carrying cost/ton of inventory
param p_supply {1..T} >= 0;            # amount available at plant
param w_demand {W_CITY,1..T} >= 0;   # amounts required at warehouses

param pd_cost {D_CITY} >= 0;    # shipment costs/1000 packages
param dw_cost {DW_LINKS} >= 0;
param pd_cap {D_CITY} >= 0;     # max packages that can be shipped
param dw_cap {DW_LINKS} >= 0;
var PD_Ship {i in D_CITY, t in 1..T} >= 0, <= pd_cap[i];
var DW_Ship {(i,j) in DW_LINKS, t in 1..T} >= 0, <= dw_cap[i,j];
                                # packages to be shipped
minimize Total_Cost:
   sum {i in D_CITY, t in 1..T} pd_cost[i] * PD_Ship[i,t] +
   sum {(i,j) in DW_LINKS, t in 1..T} dw_cost[i,j] * DW_Ship[i,j,t] + 
   sum {i in D_CITY, t in 1..T} Inv[i,t] * invcost[i];

subject to P_Bal {t in 1..T}: p_supply[t] = sum {i in D_CITY} PD_Ship[i,t];
subject to D_Bal {i in D_CITY, t in 1..T}:   			
   PD_Ship[i,t] + Inv[i,t-1]= Inv[i,t] + sum {(i,j) in DW_LINKS} DW_Ship[i,j,t];
subject to W_Bal {j in W_CITY,t in 1..T}:  
   sum {(i,j) in DW_LINKS} DW_Ship[i,j,t] = w_demand[j,t];
subject to Init_Inv {i in D_CITY}: Inv[i,0] = inv0[i];
# Initial inventory must equal given value
