function [residual, g1, g2, g3] = rbc_main_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [M_.exo_nbr by nperiods] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           columns: equations in order of declaration
%                                                           rows: variables in order stored in M_.lead_lag_incidence
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              columns: equations in order of declaration
%                                                              rows: variables in order stored in M_.lead_lag_incidence
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              columns: equations in order of declaration
%                                                              rows: variables in order stored in M_.lead_lag_incidence
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(12, 1);
T29 = y(13)*y(16)^params(9)*y(1)^params(1);
T32 = y(12)^(1-params(1));
lhs =1/y(9);
rhs =params(2)*1/y(18)*(y(19)+1-params(3));
residual(1)= lhs-rhs;
lhs =y(6);
rhs =T29*T32;
residual(2)= lhs-rhs;
lhs =y(8);
rhs =y(7)+(1-params(3))*y(1);
residual(3)= lhs-rhs;
lhs =y(6);
rhs =y(9)+y(7)+y(17);
residual(4)= lhs-rhs;
lhs =y(12);
rhs =1;
residual(5)= lhs-rhs;
lhs =y(10);
rhs =y(6)*params(1)/y(1);
residual(6)= lhs-rhs;
lhs =y(11);
rhs =y(6)*(1-params(1))/y(12);
residual(7)= lhs-rhs;
lhs =log(y(13));
rhs =params(4)*log(y(2))+x(it_, 1);
residual(8)= lhs-rhs;
lhs =y(17)+y(14);
rhs =y(15);
residual(9)= lhs-rhs;
lhs =y(17);
rhs =(1-params(7))*params(8)+params(7)*y(5)+x(it_, 3);
residual(10)= lhs-rhs;
lhs =y(16);
rhs =y(17)+(1-params(3))*y(4);
residual(11)= lhs-rhs;
lhs =y(14);
rhs =(1-params(5))*params(6)+params(5)*y(3)+x(it_, 2);
residual(12)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(12, 22);

  %
  % Jacobian matrix
  %

  g1(1,9)=(-1)/(y(9)*y(9));
  g1(1,18)=(-((y(19)+1-params(3))*params(2)*(-1)/(y(18)*y(18))));
  g1(1,19)=(-(params(2)*1/y(18)));
  g1(2,6)=1;
  g1(2,1)=(-(T32*y(13)*y(16)^params(9)*getPowerDeriv(y(1),params(1),1)));
  g1(2,12)=(-(T29*getPowerDeriv(y(12),1-params(1),1)));
  g1(2,13)=(-(T32*y(16)^params(9)*y(1)^params(1)));
  g1(2,16)=(-(T32*y(1)^params(1)*y(13)*getPowerDeriv(y(16),params(9),1)));
  g1(3,7)=(-1);
  g1(3,1)=(-(1-params(3)));
  g1(3,8)=1;
  g1(4,6)=1;
  g1(4,7)=(-1);
  g1(4,9)=(-1);
  g1(4,17)=(-1);
  g1(5,12)=1;
  g1(6,6)=(-(params(1)/y(1)));
  g1(6,1)=(-((-(y(6)*params(1)))/(y(1)*y(1))));
  g1(6,10)=1;
  g1(7,6)=(-((1-params(1))/y(12)));
  g1(7,11)=1;
  g1(7,12)=(-((-(y(6)*(1-params(1))))/(y(12)*y(12))));
  g1(8,2)=(-(params(4)*1/y(2)));
  g1(8,13)=1/y(13);
  g1(8,20)=(-1);
  g1(9,14)=1;
  g1(9,15)=(-1);
  g1(9,17)=1;
  g1(10,5)=(-params(7));
  g1(10,17)=1;
  g1(10,22)=(-1);
  g1(11,4)=(-(1-params(3)));
  g1(11,16)=1;
  g1(11,17)=(-1);
  g1(12,3)=(-params(5));
  g1(12,14)=1;
  g1(12,21)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],12,484);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],12,10648);
end
end
