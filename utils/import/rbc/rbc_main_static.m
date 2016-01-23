function [residual, g1, g2] = rbc_main_static(y, x, params)
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

residual = zeros( 12, 1);

%
% Model equations
%

T27 = y(8)*y(11)^params(9)*y(3)^params(1);
T30 = y(7)^(1-params(1));
lhs =1/y(4);
rhs =1/y(4)*params(2)*(y(5)+1-params(3));
residual(1)= lhs-rhs;
lhs =y(1);
rhs =T27*T30;
residual(2)= lhs-rhs;
lhs =y(3);
rhs =y(2)+(1-params(3))*y(3);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =y(4)+y(2)+y(12);
residual(4)= lhs-rhs;
lhs =y(7);
rhs =1;
residual(5)= lhs-rhs;
lhs =y(5);
rhs =y(1)*params(1)/y(3);
residual(6)= lhs-rhs;
lhs =y(6);
rhs =y(1)*(1-params(1))/y(7);
residual(7)= lhs-rhs;
lhs =log(y(8));
rhs =log(y(8))*params(4)+x(1);
residual(8)= lhs-rhs;
lhs =y(12)+y(9);
rhs =y(10);
residual(9)= lhs-rhs;
lhs =y(12);
rhs =(1-params(7))*params(8)+y(12)*params(7)+x(3);
residual(10)= lhs-rhs;
lhs =y(11);
rhs =y(12)+(1-params(3))*y(11);
residual(11)= lhs-rhs;
lhs =y(9);
rhs =(1-params(5))*params(6)+y(9)*params(5)+x(2);
residual(12)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(12, 12);

  %
  % Jacobian matrix
  %

  g1(1,4)=(-1)/(y(4)*y(4))-(y(5)+1-params(3))*params(2)*(-1)/(y(4)*y(4));
  g1(1,5)=(-(1/y(4)*params(2)));
  g1(2,1)=1;
  g1(2,3)=(-(T30*y(8)*y(11)^params(9)*getPowerDeriv(y(3),params(1),1)));
  g1(2,7)=(-(T27*getPowerDeriv(y(7),1-params(1),1)));
  g1(2,8)=(-(T30*y(11)^params(9)*y(3)^params(1)));
  g1(2,11)=(-(T30*y(3)^params(1)*y(8)*getPowerDeriv(y(11),params(9),1)));
  g1(3,2)=(-1);
  g1(3,3)=1-(1-params(3));
  g1(4,1)=1;
  g1(4,2)=(-1);
  g1(4,4)=(-1);
  g1(4,12)=(-1);
  g1(5,7)=1;
  g1(6,1)=(-(params(1)/y(3)));
  g1(6,3)=(-((-(y(1)*params(1)))/(y(3)*y(3))));
  g1(6,5)=1;
  g1(7,1)=(-((1-params(1))/y(7)));
  g1(7,6)=1;
  g1(7,7)=(-((-(y(1)*(1-params(1))))/(y(7)*y(7))));
  g1(8,8)=1/y(8)-params(4)*1/y(8);
  g1(9,9)=1;
  g1(9,10)=(-1);
  g1(9,12)=1;
  g1(10,12)=1-params(7);
  g1(11,11)=1-(1-params(3));
  g1(11,12)=(-1);
  g1(12,9)=1-params(5);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],12,144);
end
end
