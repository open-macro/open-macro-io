function [residual, g1, g2] = ca_main_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                    columns: equations in order of declaration
%                                                    rows: variables in declaration order
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: equations in order of declaration
%                                                       rows: variables in declaration order
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 22, 1);

%
% Model equations
%

T22 = y(1)^(-params(3));
T37 = params(13)/params(14)^2;
T55 = T22-params(6)*(1+params(21))*params(22)*y(22)^(-params(3));
T71 = y(3)^params(2);
T75 = y(2)^(params(1)-1);
T97 = y(2)^params(1);
T99 = y(3)^(params(2)-1);
T224 = getPowerDeriv(y(1),(-params(3)),1);
T325 = (-(params(6)*(1+params(21))*params(22)*getPowerDeriv(y(22),(-params(3)),1)));
lhs =y(21);
rhs =params(23)+x(9)+x(10)-x(11)-x(12);
residual(1)= lhs-rhs;
lhs =0;
rhs =T22-T22*params(6)*(1+params(21))*params(22)-(1+y(8)+y(6)*T37*(params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-params(15)))*params(6)*T55;
residual(2)= lhs-rhs;
lhs =0;
rhs =(-(T22-T22*params(6)*(1+params(21))*params(22)))/params(8)+(1-params(4))*params(6)*T55/params(8)+T71*T75*params(1)*y(21)*params(6)*T55;
residual(3)= lhs-rhs;
lhs =0;
rhs =(-(T22-T22*params(6)*(1+params(21))*params(22)))/params(9)+(1-params(5))*params(6)*T55/params(9)+T97*T99*params(2)*y(21)*params(6)*T55;
residual(4)= lhs-rhs;
lhs =0;
rhs =y(18)+y(11)+(1+params(21))*y(6)-(1+y(8))*y(6)-y(19)-y(4)-y(5)-y(17)-y(15)-y(16)+y(20);
residual(5)= lhs-rhs;
lhs =0;
rhs =y(11)-T71*y(21)*T97;
residual(6)= lhs-rhs;
lhs =0;
rhs =(1+params(21))*y(2)-(1-params(4))*y(2)-params(8)*y(4);
residual(7)= lhs-rhs;
lhs =0;
rhs =(1+params(21))*y(3)-y(3)*(1-params(5))-params(9)*y(5);
residual(8)= lhs-rhs;
lhs =y(8);
rhs =params(12)+T37*(exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-(y(6)-params(18)-params(17)*y(13))*params(15)-params(16));
residual(9)= lhs-rhs;
lhs =0;
rhs =y(12)-y(19)-y(4)-y(5)-y(17)-y(16)-y(15)-y(10);
residual(10)= lhs-rhs;
lhs =0;
rhs =y(6)+y(7);
residual(11)= lhs-rhs;
lhs =y(9);
rhs =y(20)+y(10)-y(8)*y(6);
residual(12)= lhs-rhs;
lhs =0;
rhs =y(12)-y(18)-y(11);
residual(13)= lhs-rhs;
lhs =0;
rhs =y(18)+(1+params(21))*y(13)/(1+params(12))-y(13);
residual(14)= lhs-rhs;
residual(15) = y(16);
residual(16) = y(15);
lhs =0;
rhs =T22-T22*params(6)*(1+params(21))*params(22)-params(7)*(y(14)^(-params(3))-params(6)*(1+params(21))*params(22)*y(14)^(-params(3)));
residual(17)= lhs-rhs;
lhs =0;
rhs =y(1)-(y(19)-params(22)*y(19));
residual(18)= lhs-rhs;
lhs =0;
rhs =y(14)-(y(17)-params(22)*y(17));
residual(19)= lhs-rhs;
lhs =y(18);
rhs =params(24)+y(12)*(x(1)+x(2)-x(3)-x(4));
residual(20)= lhs-rhs;
lhs =y(20);
rhs =params(35)+y(12)*(x(5)+x(6)-x(7)-x(8));
residual(21)= lhs-rhs;
lhs =y(22);
rhs =y(1);
residual(22)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(22, 22);

  %
  % Jacobian matrix
  %

  g1(1,21)=1;
  g1(2,1)=(-(T224-params(6)*(1+params(21))*params(22)*T224-(1+y(8)+y(6)*T37*(params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-params(15)))*params(6)*T224));
  g1(2,6)=params(6)*T55*(T37*(params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-params(15))+y(6)*T37*params(14)*params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13))));
  g1(2,8)=params(6)*T55;
  g1(2,13)=params(6)*T55*y(6)*T37*params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))*params(14)*(-params(17));
  g1(2,22)=(1+y(8)+y(6)*T37*(params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-params(15)))*params(6)*T325;
  g1(3,1)=(-((-(T224-params(6)*(1+params(21))*params(22)*T224))/params(8)+(1-params(4))*params(6)*T224/params(8)+T71*T75*params(1)*y(21)*params(6)*T224));
  g1(3,2)=(-(T71*params(1)*y(21)*params(6)*T55*getPowerDeriv(y(2),params(1)-1,1)));
  g1(3,3)=(-(T75*params(1)*y(21)*params(6)*T55*getPowerDeriv(y(3),params(2),1)));
  g1(3,21)=(-(T71*T75*params(6)*T55*params(1)));
  g1(3,22)=(-((1-params(4))*params(6)*T325/params(8)+T71*T75*params(1)*y(21)*params(6)*T325));
  g1(4,1)=(-((-(T224-params(6)*(1+params(21))*params(22)*T224))/params(9)+(1-params(5))*params(6)*T224/params(9)+T97*T99*params(2)*y(21)*params(6)*T224));
  g1(4,2)=(-(T99*params(2)*y(21)*params(6)*T55*getPowerDeriv(y(2),params(1),1)));
  g1(4,3)=(-(T97*params(2)*y(21)*params(6)*T55*getPowerDeriv(y(3),params(2)-1,1)));
  g1(4,21)=(-(T97*T99*params(6)*T55*params(2)));
  g1(4,22)=(-((1-params(5))*params(6)*T325/params(9)+T97*T99*params(2)*y(21)*params(6)*T325));
  g1(5,4)=1;
  g1(5,5)=1;
  g1(5,6)=(-(1+params(21)-(1+y(8))));
  g1(5,8)=y(6);
  g1(5,11)=(-1);
  g1(5,15)=1;
  g1(5,16)=1;
  g1(5,17)=1;
  g1(5,18)=(-1);
  g1(5,19)=1;
  g1(5,20)=(-1);
  g1(6,2)=T71*y(21)*getPowerDeriv(y(2),params(1),1);
  g1(6,3)=y(21)*T97*getPowerDeriv(y(3),params(2),1);
  g1(6,11)=(-1);
  g1(6,21)=T71*T97;
  g1(7,2)=(-(1+params(21)-(1-params(4))));
  g1(7,4)=params(8);
  g1(8,3)=(-(1+params(21)-(1-params(5))));
  g1(8,5)=params(9);
  g1(9,6)=(-(T37*(params(14)*exp(params(14)*(y(6)-params(18)-params(17)*y(13)))-params(15))));
  g1(9,8)=1;
  g1(9,13)=(-(T37*(exp(params(14)*(y(6)-params(18)-params(17)*y(13)))*params(14)*(-params(17))-params(15)*(-params(17)))));
  g1(10,4)=1;
  g1(10,5)=1;
  g1(10,10)=1;
  g1(10,12)=(-1);
  g1(10,15)=1;
  g1(10,16)=1;
  g1(10,17)=1;
  g1(10,19)=1;
  g1(11,6)=(-1);
  g1(11,7)=(-1);
  g1(12,6)=y(8);
  g1(12,8)=y(6);
  g1(12,9)=1;
  g1(12,10)=(-1);
  g1(12,20)=(-1);
  g1(13,11)=1;
  g1(13,12)=(-1);
  g1(13,18)=1;
  g1(14,13)=(-((1+params(21))/(1+params(12))-1));
  g1(14,18)=(-1);
  g1(15,16)=1;
  g1(16,15)=1;
  g1(17,1)=(-(T224-params(6)*(1+params(21))*params(22)*T224));
  g1(17,14)=params(7)*(getPowerDeriv(y(14),(-params(3)),1)-params(6)*(1+params(21))*params(22)*getPowerDeriv(y(14),(-params(3)),1));
  g1(18,1)=(-1);
  g1(18,19)=1-params(22);
  g1(19,14)=(-1);
  g1(19,17)=1-params(22);
  g1(20,12)=(-(x(1)+x(2)-x(3)-x(4)));
  g1(20,18)=1;
  g1(21,12)=(-(x(5)+x(6)-x(7)-x(8)));
  g1(21,20)=1;
  g1(22,1)=(-1);
  g1(22,22)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],22,484);
end
end
