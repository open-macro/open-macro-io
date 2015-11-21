# find a value of Abar that ensures yss = 1
# only run this script if the model is (is not?) off steady state

    iter_        = 0;
    maxIter      = 500;
    notConverged = true;
    lambda_      = 0.025;
    tol_         = 1e-5;

    # set an initial value of Abar
    Aguess = 1.1;

    # loop to search for correct value
    while (iter_ < maxIter) && (notConverged)
      iter_ = iter_ +1;

      # find steady state with current Abar guess
      Abar = Aguess;
      calc_sstate;  

      # increment Abar by a tiny amount
      eps_step = eps^(5/9);
      y0       = yvalue;
      A0       = Abar;
      Abar     = Abar + eps_step; 
      
      # find steady state with updated Abar
      calc_sstate;

      # get the vector of changes & form the derivative
      y_       = yvalue;
      dyy_     = (y_ - y0) ./ eps_step;
      getj_    = dyy_;
      A_base   = Abar;
      y_base   = yvalue;
      y_desire = 1;
      dy_      = [y_desire - y_base];
      dA_      = getj_\dy_;
      Aguess   = lambda_*dA_ + A_base;

      # check for convergence
      if abs(dy_) < tol_
        notConverged = false;
      end # end convergence check

    end # end while loop
