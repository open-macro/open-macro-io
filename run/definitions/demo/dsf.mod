@#define exogenous = 1
@#define endogenous_domestic = 0
@#define endogenous_commercial = 0

@#include "dsf_main.mod"
@#include "shocks.mod"

options_.debug=1;
simul(periods=750);