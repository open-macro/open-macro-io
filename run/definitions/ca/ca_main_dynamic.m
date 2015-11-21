function [residual, g1, g2, g3] = ca_main_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(22, 1);
T32 = y(7)^(-params(3))-params(6)*(1+params(21))*params(22)*y(29)^(-params(3));
T44 = params(13)/params(14)^2;
T76 = y(8)^(params(1)-1);
T80 = y(9)^params(2);
T86 = T32*1/(1+params(21))*params(10);
T89 = y(8)/y(1)-1;
T92 = params(10)/2;
T95 = y(30)/y(8);
T96 = T95-1;
T97 = T96^2;
T115 = y(9)^(params(2)-1);
T117 = y(8)^params(1);
T121 = T32*1/(1+params(21))*params(11);
T124 = y(9)/y(2)-1;
T127 = params(11)/2;
T130 = y(31)/y(9);
T131 = T130-1;
T132 = T131^2;
T274 = y(29)^(-params(3))-params(6)*(1+params(21))*params(22)*y(34)^(-params(3));
T315 = (-(getPowerDeriv(y(7),(-params(3)),1)));
T317 = 1/(1+params(21))*getPowerDeriv(y(7),(-params(3)),1);
T327 = getPowerDeriv(y(29),(-params(3)),1);
T530 = (-(params(6)*(1+params(21))*params(22)*getPowerDeriv(y(34),(-params(3)),1)));
T531 = params(6)*T530;
lhs =y(27);
rhs =params(23)+x(it_, 9)+x(it_, 10)-x(it_, 11)-x(it_, 12);
residual(1)= lhs-rhs;
lhs =0;
rhs =T32-(1+y(14)+y(12)*T44*(params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-params(15)))*params(6)*T274;
residual(2)= lhs-rhs;
lhs =0;
rhs =(-T32)/params(8)+(1-params(4))*params(6)*T274/params(8)+T80*T76*params(1)*y(27)*params(6)*T274-T86*T89-T97*T92*params(6)*T274+T95*T96*params(10)*params(6)*T274;
residual(3)= lhs-rhs;
lhs =0;
rhs =(-T32)/params(9)+(1-params(5))*params(6)*T274/params(9)+T117*T115*params(2)*y(27)*params(6)*T274-T121*T124-T132*T127*params(6)*T274+T130*T131*params(11)*params(6)*T274;
residual(4)= lhs-rhs;
lhs =0;
rhs =y(24)+y(17)+(1+params(21))*y(12)-(1+y(4))*y(3)-y(25)-y(10)-y(11)-y(23)-y(21)-y(22)+y(26);
residual(5)= lhs-rhs;
lhs =0;
rhs =y(17)-y(27)*y(1)^params(1)*y(2)^params(2);
residual(6)= lhs-rhs;
lhs =0;
rhs =(1+params(21))*y(8)-(1-params(4))*y(1)-params(8)*y(10);
residual(7)= lhs-rhs;
lhs =0;
rhs =(1+params(21))*y(9)-(1-params(5))*y(2)-params(9)*y(11);
residual(8)= lhs-rhs;
lhs =y(14);
rhs =params(12)+T44*(exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-(y(12)-params(18)-params(17)*y(19))*params(15)-params(16));
residual(9)= lhs-rhs;
lhs =0;
rhs =y(18)-y(25)-y(10)-y(11)-y(23)-y(22)-y(21)-y(16);
residual(10)= lhs-rhs;
lhs =0;
rhs =y(12)+y(13);
residual(11)= lhs-rhs;
lhs =y(15);
rhs =y(26)+y(16)-y(4)*y(3);
residual(12)= lhs-rhs;
lhs =0;
rhs =y(18)-y(24)-y(17);
residual(13)= lhs-rhs;
lhs =0;
rhs =y(24)+(1+params(21))*y(32)/(1+params(12))-y(19);
residual(14)= lhs-rhs;
lhs =y(22);
rhs =y(1)*T92*T89^2;
residual(15)= lhs-rhs;
lhs =y(21);
rhs =y(2)*T127*T124^2;
residual(16)= lhs-rhs;
lhs =0;
rhs =T32-params(7)*(y(20)^(-params(3))-params(6)*(1+params(21))*params(22)*y(33)^(-params(3)));
residual(17)= lhs-rhs;
lhs =0;
rhs =y(7)-(y(25)-params(22)*y(6));
residual(18)= lhs-rhs;
lhs =0;
rhs =y(20)-(y(23)-params(22)*y(5));
residual(19)= lhs-rhs;
lhs =y(24);
rhs =params(24)+y(18)*(x(it_, 1)+x(it_, 2)-x(it_, 3)-x(it_, 4));
residual(20)= lhs-rhs;
lhs =y(26);
rhs =params(35)+y(18)*(x(it_, 5)+x(it_, 6)-x(it_, 7)-x(it_, 8));
residual(21)= lhs-rhs;
lhs =y(28);
rhs =y(29);
residual(22)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(22, 46);

  %
  % Jacobian matrix
  %

  g1(1,27)=1;
  g1(1,43)=(-1);
  g1(1,44)=(-1);
  g1(1,45)=1;
  g1(1,46)=1;
  g1(2,7)=T315;
  g1(2,29)=(-((-(params(6)*(1+params(21))*params(22)*T327))-(1+y(14)+y(12)*T44*(params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-params(15)))*params(6)*T327));
  g1(2,12)=params(6)*T274*(T44*(params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-params(15))+y(12)*T44*params(14)*params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19))));
  g1(2,14)=params(6)*T274;
  g1(2,19)=params(6)*T274*y(12)*T44*params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))*params(14)*(-params(17));
  g1(2,34)=(1+y(14)+y(12)*T44*(params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-params(15)))*T531;
  g1(3,7)=(-(T315/params(8)-T89*params(10)*T317));
  g1(3,29)=(-(params(6)*(1+params(21))*params(22)*T327/params(8)+(1-params(4))*params(6)*T327/params(8)+T80*T76*params(1)*y(27)*params(6)*T327-T89*params(10)*1/(1+params(21))*(-(params(6)*(1+params(21))*params(22)*T327))-T97*T92*params(6)*T327+T95*T96*params(10)*params(6)*T327));
  g1(3,1)=T86*(-y(8))/(y(1)*y(1));
  g1(3,8)=(-(T80*params(1)*y(27)*params(6)*T274*getPowerDeriv(y(8),params(1)-1,1)-T86*1/y(1)-T92*params(6)*T274*(-y(30))/(y(8)*y(8))*2*T96+T96*params(10)*params(6)*T274*(-y(30))/(y(8)*y(8))+T95*params(10)*params(6)*T274*(-y(30))/(y(8)*y(8))));
  g1(3,30)=(-((-(T92*params(6)*T274*2*T96*1/y(8)))+T96*params(10)*params(6)*T274*1/y(8)+T95*params(10)*params(6)*T274*1/y(8)));
  g1(3,9)=(-(T76*params(1)*y(27)*params(6)*T274*getPowerDeriv(y(9),params(2),1)));
  g1(3,27)=(-(T80*T76*params(1)*params(6)*T274));
  g1(3,34)=(-((1-params(4))*params(6)*T530/params(8)+T80*T76*params(1)*y(27)*T531-T97*T92*T531+T95*T96*params(10)*T531));
  g1(4,7)=(-(T315/params(9)-T124*params(11)*T317));
  g1(4,29)=(-(params(6)*(1+params(21))*params(22)*T327/params(9)+(1-params(5))*params(6)*T327/params(9)+T117*T115*params(2)*y(27)*params(6)*T327-T124*params(11)*1/(1+params(21))*(-(params(6)*(1+params(21))*params(22)*T327))-T132*T127*params(6)*T327+T130*T131*params(11)*params(6)*T327));
  g1(4,8)=(-(T115*params(2)*y(27)*params(6)*T274*getPowerDeriv(y(8),params(1),1)));
  g1(4,2)=T121*(-y(9))/(y(2)*y(2));
  g1(4,9)=(-(T117*params(2)*y(27)*params(6)*T274*getPowerDeriv(y(9),params(2)-1,1)-T121*1/y(2)-T127*params(6)*T274*(-y(31))/(y(9)*y(9))*2*T131+T131*params(11)*params(6)*T274*(-y(31))/(y(9)*y(9))+T130*params(11)*params(6)*T274*(-y(31))/(y(9)*y(9))));
  g1(4,31)=(-((-(T127*params(6)*T274*2*T131*1/y(9)))+T131*params(11)*params(6)*T274*1/y(9)+T130*params(11)*params(6)*T274*1/y(9)));
  g1(4,27)=(-(T117*T115*params(2)*params(6)*T274));
  g1(4,34)=(-((1-params(5))*params(6)*T530/params(9)+T117*T115*params(2)*y(27)*T531-T132*T127*T531+T130*T131*params(11)*T531));
  g1(5,10)=1;
  g1(5,11)=1;
  g1(5,3)=1+y(4);
  g1(5,12)=(-(1+params(21)));
  g1(5,4)=y(3);
  g1(5,17)=(-1);
  g1(5,21)=1;
  g1(5,22)=1;
  g1(5,23)=1;
  g1(5,24)=(-1);
  g1(5,25)=1;
  g1(5,26)=(-1);
  g1(6,1)=y(2)^params(2)*y(27)*getPowerDeriv(y(1),params(1),1);
  g1(6,2)=y(27)*y(1)^params(1)*getPowerDeriv(y(2),params(2),1);
  g1(6,17)=(-1);
  g1(6,27)=y(1)^params(1)*y(2)^params(2);
  g1(7,1)=1-params(4);
  g1(7,8)=(-(1+params(21)));
  g1(7,10)=params(8);
  g1(8,2)=1-params(5);
  g1(8,9)=(-(1+params(21)));
  g1(8,11)=params(9);
  g1(9,12)=(-(T44*(params(14)*exp(params(14)*(y(12)-params(18)-params(17)*y(19)))-params(15))));
  g1(9,14)=1;
  g1(9,19)=(-(T44*(exp(params(14)*(y(12)-params(18)-params(17)*y(19)))*params(14)*(-params(17))-params(15)*(-params(17)))));
  g1(10,10)=1;
  g1(10,11)=1;
  g1(10,16)=1;
  g1(10,18)=(-1);
  g1(10,21)=1;
  g1(10,22)=1;
  g1(10,23)=1;
  g1(10,25)=1;
  g1(11,12)=(-1);
  g1(11,13)=(-1);
  g1(12,3)=y(4);
  g1(12,4)=y(3);
  g1(12,15)=1;
  g1(12,16)=(-1);
  g1(12,26)=(-1);
  g1(13,17)=1;
  g1(13,18)=(-1);
  g1(13,24)=1;
  g1(14,19)=1;
  g1(14,32)=(-((1+params(21))/(1+params(12))));
  g1(14,24)=(-1);
  g1(15,1)=(-(T92*T89^2+y(1)*T92*(-y(8))/(y(1)*y(1))*2*T89));
  g1(15,8)=(-(y(1)*T92*2*T89*1/y(1)));
  g1(15,22)=1;
  g1(16,2)=(-(T127*T124^2+y(2)*T127*(-y(9))/(y(2)*y(2))*2*T124));
  g1(16,9)=(-(y(2)*T127*2*T124*1/y(2)));
  g1(16,21)=1;
  g1(17,7)=T315;
  g1(17,29)=params(6)*(1+params(21))*params(22)*T327;
  g1(17,20)=params(7)*getPowerDeriv(y(20),(-params(3)),1);
  g1(17,33)=params(7)*(-(params(6)*(1+params(21))*params(22)*getPowerDeriv(y(33),(-params(3)),1)));
  g1(18,7)=(-1);
  g1(18,6)=(-params(22));
  g1(18,25)=1;
  g1(19,20)=(-1);
  g1(19,5)=(-params(22));
  g1(19,23)=1;
  g1(20,18)=(-(x(it_, 1)+x(it_, 2)-x(it_, 3)-x(it_, 4)));
  g1(20,24)=1;
  g1(20,35)=(-y(18));
  g1(20,36)=(-y(18));
  g1(20,37)=y(18);
  g1(20,38)=y(18);
  g1(21,18)=(-(x(it_, 5)+x(it_, 6)-x(it_, 7)-x(it_, 8)));
  g1(21,26)=1;
  g1(21,39)=(-y(18));
  g1(21,40)=(-y(18));
  g1(21,41)=y(18);
  g1(21,42)=y(18);
  g1(22,29)=(-1);
  g1(22,28)=1;
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],22,2116);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],22,97336);
end
end
