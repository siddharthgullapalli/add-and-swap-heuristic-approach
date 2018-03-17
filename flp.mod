set demand;
set depot;
set est within depot;
set clos within depot;


param c{j in depot,i in demand}; # delivery cost
param f{j in depot}; #set up cost 
param d{i in demand}; # demand in each location
param dcap{j in depot}; #service capacity of the facility


var x{demand,depot} >=0; # variable to determine which facilities helps in satisfying the demand in a location 
var y{depot} binary; # variable for the establishment of the facility

minimize cost: sum{i in demand, j in depot} x[i,j]*c[j,i]+sum{j in depot}y[j]*f[j]; #minimizing the total cost


subject to c1{i in demand}: sum{j in depot} x[i,j] = 1; # the demand must be satisfied
subject to c2{j in depot}: sum{i in demand}x[i,j]*d[i] <=dcap[j]; #the demand that is satisfied shoud be less than the facilities capacity
subject to c4{i in demand, j in depot}: x[i,j]<=y[j]; #demand should be satisfied by the established facilities
subject to c6:sum{j in est} y[j] = 7; #add and swap heuristic approach
subject to c7:sum{j in clos} y[j] = 0;
