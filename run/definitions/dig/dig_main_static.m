function [residual, g1, g2] = dig_main_static(y, x, params)
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

residual = zeros( 45, 1);

%
% Model equations
%

Robx__ = params(40)/2*y(16)*(y(13)/y(16)-params(17)-params(25))^2;
Robn__ = params(39)/2*y(15)*(y(12)/y(15)-params(16)-params(25))^2;
compn__ = (1-params(54)-params(53))*y(25)^(-params(21))/(params(53)*y(23)^(1-params(21))+params(54)*y(26)^(1-params(21))+(1-params(54)-params(53))*y(25)^(1-params(21)));
Jimz__ = ((params(25)+params(18))*params(71)+(1+y(14)/y(44)-params(18)-params(25))^params(45)*(y(14)-(params(25)+params(18))*params(71)))/y(14);
DD__ = y(14)*y(27)*Jimz__+(1+y(31))*y(3)/(1+params(25))-y(3)+(1+y(35))*y(4)/(1+params(25))-y(4)+y(21)*(1+y(30))*y(1)/(1+params(25))-y(21)*y(1)+params(65)-(y(6)+y(7))*params(30)-(y(9)+y(20))-y(45)*params(37);
DDo__ = params(65)+params(14)*(y(31)-params(25))/(1+params(25))+params(15)*(params(56)+params(41)-params(25))/(1+params(25))+(params(55)-params(25))*params(12)/(1+params(25))+params(71)*(params(25)+params(18))*params(44)-params(30)*(params(20)+params(19))-(params(29)+params(42))-params(37)*params(70);
h_target__ = params(30)+(1-params(31))*y(8)/(y(6)+y(7));
T_target__ = params(65)-params(31)*y(8);
uazuaz__ = params(69)/y(43);
uaz__ = params(69)*y(27)/params(44)/y(43);
foo__ = y(3)/(1+params(25));
int_repayment__ = x(73)+x(74)+x(75)-x(76)-x(77)-x(78);
T9 = params(40)/2;
T21 = params(39)/2;
T39 = (1-params(54)-params(53))*y(25)^(-params(21));
T47 = params(53)*y(23)^(1-params(21))+params(54)*y(26)^(1-params(21));
T50 = T47+(1-params(54)-params(53))*y(25)^(1-params(21));
T63 = (1+y(14)/y(44)-params(18)-params(25))^params(45);
T228 = params(4)*(y(29)/params(49))^params(63);
T231 = T228*y(45)^params(47);
T235 = y(16)^(params(68)+params(8));
T239 = y(18)^(1-params(8));
T247 = params(2)*(y(28)/params(48))^params(62);
T250 = T247*y(45)^params(46);
T254 = y(15)^(params(67)+params(7));
T258 = y(17)^(1-params(7));
T274 = T47+y(25)^(1-params(21))*(1-params(53)-params(54));
T288 = params(40)*(y(13)/y(16)-params(17)-params(25));
T299 = T9*(y(13)/y(16)-params(17)-params(25))^2;
T302 = params(39)*(y(12)/y(15)-params(16)-params(25));
T313 = T21*(y(12)/y(15)-params(16)-params(25))^2;
T430 = exp(params(23)*(y(3)/y(43)+y(4)/y(43)-params(14)/params(69)-params(15)/params(69)));
T685 = 1/y(15)*2*(y(12)/y(15)-params(16)-params(25));
T702 = 1/y(16)*2*(y(13)/y(16)-params(17)-params(25));
T713 = getPowerDeriv(1+y(14)/y(44)-params(18)-params(25),params(45),1);
T720 = (y(14)*(T63+(y(14)-(params(25)+params(18))*params(71))*1/y(44)*T713)-((params(25)+params(18))*params(71)+T63*(y(14)-(params(25)+params(18))*params(71))))/(y(14)*y(14));
T741 = 2*(y(12)/y(15)-params(16)-params(25))*(-y(12))/(y(15)*y(15));
T766 = 2*(y(13)/y(16)-params(17)-params(25))*(-y(13))/(y(16)*y(16));
T806 = getPowerDeriv(T274,1/(1-params(21)),1);
T919 = (-(params(3)/(1+params(3))/(1+y(11))));
T939 = (-params(69))/(y(43)*y(43));
T1030 = (y(14)-(params(25)+params(18))*params(71))*T713*(-y(14))/(y(44)*y(44))/y(14);
lhs =y(29);
rhs =T231*T235*T239;
residual(1)= lhs-rhs;
lhs =y(28);
rhs =T250*T254*T258;
residual(2)= lhs-rhs;
lhs =y(22);
rhs =y(24)+y(25)*params(1);
residual(3)= lhs-rhs;
lhs =y(27);
rhs =y(24)+y(25)*params(5);
residual(4)= lhs-rhs;
lhs =y(21);
rhs =T274^(1/(1-params(21)));
residual(5)= lhs-rhs;
lhs =1;
rhs =(1+y(30))*params(11)*(1+y(11))/((1+params(25))*(1+y(11)));
residual(6)= lhs-rhs;
lhs =(1+y(30))*(1+T288);
rhs =y(37)/y(22)+1-params(17)+T288*(1+y(13)/y(16)-params(17))-T299;
residual(7)= lhs-rhs;
lhs =(1+y(30))*(1+T302);
rhs =y(36)/y(22)+1-params(16)+T302*(1+y(12)/y(15)-params(16))-T313;
residual(8)= lhs-rhs;
lhs =1+y(34);
rhs =y(21)*(1+y(30))*(1-params(22)*(y(2)-params(13)))/y(21);
residual(9)= lhs-rhs;
lhs =y(16)*(1+params(25));
rhs =y(13)+y(16)*(1-params(17));
residual(10)= lhs-rhs;
lhs =y(15)*(1+params(25));
rhs =y(12)+y(15)*(1-params(16));
residual(11)= lhs-rhs;
lhs =y(44)*(1+params(25));
rhs =y(14)+y(44)*(1-params(18));
residual(12)= lhs-rhs;
lhs =y(45);
rhs =params(71)*params(58)+params(57)*(y(44)-params(71));
residual(13)= lhs-rhs;
lhs =y(28)*y(25)*(1-params(7))/y(17);
rhs =y(42);
residual(14)= lhs-rhs;
lhs =y(29)*y(26)*(1-params(8))/y(18);
rhs =y(42);
residual(15)= lhs-rhs;
lhs =y(28)*y(25)*params(7)/y(15);
rhs =y(36);
residual(16)= lhs-rhs;
lhs =y(29)*y(26)*params(8)/y(16);
rhs =y(37);
residual(17)= lhs-rhs;
lhs =y(28);
rhs =(y(6)+y(7))*compn__+params(1)*(y(13)+y(12)+Robx__+Robn__)+y(14)*Jimz__*params(5);
residual(18)= lhs-rhs;
lhs =y(18)+y(17);
rhs =(1+params(3))*params(36);
residual(19)= lhs-rhs;
lhs =y(2)+y(3)+y(4);
rhs =(1+y(35))*y(4)/(1+params(25))+(1+y(31))*y(3)/(1+params(25))+y(14)*y(27)*Jimz__+y(6)+y(7)+y(22)*(y(13)+y(12)+Robx__+Robn__)+(1+y(34))*y(2)/(1+params(25))+params(22)/2*(y(2)-params(13))^2-y(25)*y(28)-y(26)*y(29)-(y(9)+y(20))-y(32);
residual(20)= lhs-rhs;
lhs =y(7);
rhs =(params(36)*y(42)*params(3)+params(3)/(1+params(3))*(y(39)+y(32)))/(1+y(11));
residual(21)= lhs-rhs;
lhs =y(38);
rhs =(y(28)*y(25)*params(46)+y(29)*y(26)*params(47))/(y(27)*y(45));
residual(22)= lhs-rhs;
lhs =y(35);
rhs =params(56)+params(41)*T430;
residual(23)= lhs-rhs;
lhs =y(34);
rhs =y(35)+params(38);
residual(24)= lhs-rhs;
lhs =y(43);
rhs =y(25)*y(28)+y(26)*y(29);
residual(25)= lhs-rhs;
lhs =y(10);
rhs =params(25);
residual(26)= lhs-rhs;
lhs =y(8);
rhs =DD__-DDo__;
residual(27)= lhs-rhs;
lhs =y(39);
rhs =T_target__;
residual(28)= lhs-rhs;
lhs =y(11);
rhs =h_target__;
residual(29)= lhs-rhs;
lhs =y(1);
rhs =params(12)+x(13)/uazuaz__+x(14)/uazuaz__+x(15)/uazuaz__-x(16)/uazuaz__-x(17)/uazuaz__-x(18)/uazuaz__;
residual(30)= lhs-rhs;
lhs =y(3);
rhs =y(3)/(1+params(25))+params(25)*params(14)/(1+params(25))+x(7)/uazuaz__+x(8)/uazuaz__+x(9)/uazuaz__-x(10)/uazuaz__-x(11)/uazuaz__-x(12)/uazuaz__;
residual(31)= lhs-rhs;
lhs =y(19);
rhs =x(9)+x(7)+x(8)-x(10)-x(11)-x(12);
residual(32)= lhs-rhs;
lhs =y(5);
rhs =x(9)+x(7)+x(8)-x(10)-x(11)-x(12)+y(5);
residual(33)= lhs-rhs;
lhs =y(4);
rhs =x(19)/uazuaz__+x(20)/uazuaz__+x(21)/uazuaz__-x(22)/uazuaz__-x(23)/uazuaz__-x(24)/uazuaz__+y(4)/(1+params(25));
residual(34)= lhs-rhs;
lhs =y(14)*uaz__;
rhs =(params(25)+params(18))*params(71)+x(1)+x(2)+x(3)-x(4)-x(5)-x(6);
residual(35)= lhs-rhs;
lhs =y(9)*uazuaz__;
rhs =params(29)+x(25)+x(26)+x(27)-x(28)-x(29)-x(30);
residual(36)= lhs-rhs;
lhs =y(20)*uazuaz__;
rhs =params(42)+x(31)+x(32)+x(33)-x(34)-x(35)-x(36);
residual(37)= lhs-rhs;
lhs =y(32)*uazuaz__;
rhs =params(52)+x(37)+x(38)+x(39)-x(40)-x(41)-x(42);
residual(38)= lhs-rhs;
lhs =y(31)*foo__;
rhs =int_repayment__/uazuaz__;
residual(39)= lhs-rhs;
lhs =y(26);
rhs =1+x(55)+x(56)+x(57)-x(58)-x(59)-x(60);
residual(40)= lhs-rhs;
lhs =y(23);
rhs =1+x(61)+x(62)+x(63)-x(64)-x(65)-x(66);
residual(41)= lhs-rhs;
lhs =y(24);
rhs =1+x(67)+x(68)+x(69)-x(70)-x(71)-x(72);
residual(42)= lhs-rhs;
lhs =y(33);
rhs =y(25)/y(26);
residual(43)= lhs-rhs;
lhs =y(40);
rhs =y(26)/y(23);
residual(44)= lhs-rhs;
lhs =y(41);
rhs =y(26)/y(24);
residual(45)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(45, 45);

  %
  % Jacobian matrix
  %

  g1(1,16)=(-(T239*T231*getPowerDeriv(y(16),params(68)+params(8),1)));
  g1(1,18)=(-(T231*T235*getPowerDeriv(y(18),1-params(8),1)));
  g1(1,29)=1-T239*T235*y(45)^params(47)*params(4)*1/params(49)*getPowerDeriv(y(29)/params(49),params(63),1);
  g1(1,45)=(-(T239*T235*T228*getPowerDeriv(y(45),params(47),1)));
  g1(2,15)=(-(T258*T250*getPowerDeriv(y(15),params(67)+params(7),1)));
  g1(2,17)=(-(T250*T254*getPowerDeriv(y(17),1-params(7),1)));
  g1(2,28)=1-T258*T254*y(45)^params(46)*params(2)*1/params(48)*getPowerDeriv(y(28)/params(48),params(62),1);
  g1(2,45)=(-(T258*T254*T247*getPowerDeriv(y(45),params(46),1)));
  g1(3,22)=1;
  g1(3,24)=(-1);
  g1(3,25)=(-params(1));
  g1(4,24)=(-1);
  g1(4,25)=(-params(5));
  g1(4,27)=1;
  g1(5,21)=1;
  g1(5,23)=(-(params(53)*getPowerDeriv(y(23),1-params(21),1)*T806));
  g1(5,25)=(-(T806*(1-params(53)-params(54))*getPowerDeriv(y(25),1-params(21),1)));
  g1(5,26)=(-(T806*params(54)*getPowerDeriv(y(26),1-params(21),1)));
  g1(6,11)=(-(((1+params(25))*(1+y(11))*(1+y(30))*params(11)-(1+params(25))*(1+y(30))*params(11)*(1+y(11)))/((1+params(25))*(1+y(11))*(1+params(25))*(1+y(11)))));
  g1(6,30)=(-(params(11)*(1+y(11))/((1+params(25))*(1+y(11)))));
  g1(7,13)=(1+y(30))*params(40)*1/y(16)-((1+y(13)/y(16)-params(17))*params(40)*1/y(16)+T288*1/y(16)-T9*T702);
  g1(7,16)=(1+y(30))*params(40)*(-y(13))/(y(16)*y(16))-((1+y(13)/y(16)-params(17))*params(40)*(-y(13))/(y(16)*y(16))+T288*(-y(13))/(y(16)*y(16))-T9*T766);
  g1(7,22)=(-((-y(37))/(y(22)*y(22))));
  g1(7,30)=1+T288;
  g1(7,37)=(-(1/y(22)));
  g1(8,12)=(1+y(30))*params(39)*1/y(15)-((1+y(12)/y(15)-params(16))*params(39)*1/y(15)+T302*1/y(15)-T21*T685);
  g1(8,15)=(1+y(30))*params(39)*(-y(12))/(y(15)*y(15))-((1+y(12)/y(15)-params(16))*params(39)*(-y(12))/(y(15)*y(15))+T302*(-y(12))/(y(15)*y(15))-T21*T741);
  g1(8,22)=(-((-y(36))/(y(22)*y(22))));
  g1(8,30)=1+T302;
  g1(8,36)=(-(1/y(22)));
  g1(9,2)=(-(y(21)*(1+y(30))*(-params(22))/y(21)));
  g1(9,30)=(-(y(21)*(1-params(22)*(y(2)-params(13)))/y(21)));
  g1(9,34)=1;
  g1(10,13)=(-1);
  g1(10,16)=1+params(25)-(1-params(17));
  g1(11,12)=(-1);
  g1(11,15)=1+params(25)-(1-params(16));
  g1(12,14)=(-1);
  g1(12,44)=1+params(25)-(1-params(18));
  g1(13,44)=(-params(57));
  g1(13,45)=1;
  g1(14,17)=(-(y(28)*y(25)*(1-params(7))))/(y(17)*y(17));
  g1(14,25)=y(28)*(1-params(7))/y(17);
  g1(14,28)=y(25)*(1-params(7))/y(17);
  g1(14,42)=(-1);
  g1(15,18)=(-(y(29)*y(26)*(1-params(8))))/(y(18)*y(18));
  g1(15,26)=y(29)*(1-params(8))/y(18);
  g1(15,29)=y(26)*(1-params(8))/y(18);
  g1(15,42)=(-1);
  g1(16,15)=(-(y(28)*y(25)*params(7)))/(y(15)*y(15));
  g1(16,25)=y(28)*params(7)/y(15);
  g1(16,28)=y(25)*params(7)/y(15);
  g1(16,36)=(-1);
  g1(17,16)=(-(y(29)*y(26)*params(8)))/(y(16)*y(16));
  g1(17,26)=y(29)*params(8)/y(16);
  g1(17,29)=y(26)*params(8)/y(16);
  g1(17,37)=(-1);
  g1(18,6)=(-compn__);
  g1(18,7)=(-compn__);
  g1(18,12)=(-(params(1)*(1+T21*y(15)*T685)));
  g1(18,13)=(-(params(1)*(1+T9*y(16)*T702)));
  g1(18,14)=(-(Jimz__*params(5)+y(14)*params(5)*T720));
  g1(18,15)=(-(params(1)*(T313+T21*y(15)*T741)));
  g1(18,16)=(-(params(1)*(T299+T9*y(16)*T766)));
  g1(18,23)=(-((y(6)+y(7))*(-(T39*params(53)*getPowerDeriv(y(23),1-params(21),1)))/(T50*T50)));
  g1(18,25)=(-((y(6)+y(7))*(T50*(1-params(54)-params(53))*getPowerDeriv(y(25),(-params(21)),1)-T39*(1-params(54)-params(53))*getPowerDeriv(y(25),1-params(21),1))/(T50*T50)));
  g1(18,26)=(-((y(6)+y(7))*(-(T39*params(54)*getPowerDeriv(y(26),1-params(21),1)))/(T50*T50)));
  g1(18,28)=1;
  g1(18,44)=(-(y(14)*params(5)*T1030));
  g1(19,17)=1;
  g1(19,18)=1;
  g1(20,2)=1-((1+y(34))/(1+params(25))+params(22)/2*2*(y(2)-params(13)));
  g1(20,3)=1-(1+y(31))/(1+params(25));
  g1(20,4)=1-(1+y(35))/(1+params(25));
  g1(20,6)=(-1);
  g1(20,7)=(-1);
  g1(20,9)=1;
  g1(20,12)=(-(y(22)*(1+T21*y(15)*T685)));
  g1(20,13)=(-(y(22)*(1+T9*y(16)*T702)));
  g1(20,14)=(-(y(27)*Jimz__+y(14)*y(27)*T720));
  g1(20,15)=(-(y(22)*(T313+T21*y(15)*T741)));
  g1(20,16)=(-(y(22)*(T299+T9*y(16)*T766)));
  g1(20,20)=1;
  g1(20,22)=(-(y(13)+y(12)+Robx__+Robn__));
  g1(20,25)=y(28);
  g1(20,26)=y(29);
  g1(20,27)=(-(y(14)*Jimz__));
  g1(20,28)=y(25);
  g1(20,29)=y(26);
  g1(20,31)=(-(y(3)/(1+params(25))));
  g1(20,32)=1;
  g1(20,34)=(-(y(2)/(1+params(25))));
  g1(20,35)=(-(y(4)/(1+params(25))));
  g1(20,44)=(-(y(14)*y(27)*T1030));
  g1(21,7)=1;
  g1(21,11)=(-((-(params(36)*y(42)*params(3)+params(3)/(1+params(3))*(y(39)+y(32))))/((1+y(11))*(1+y(11)))));
  g1(21,32)=T919;
  g1(21,39)=T919;
  g1(21,42)=(-(params(3)*params(36)/(1+y(11))));
  g1(22,25)=(-(y(28)*params(46)/(y(27)*y(45))));
  g1(22,26)=(-(y(29)*params(47)/(y(27)*y(45))));
  g1(22,27)=(-((-(y(45)*(y(28)*y(25)*params(46)+y(29)*y(26)*params(47))))/(y(27)*y(45)*y(27)*y(45))));
  g1(22,28)=(-(y(25)*params(46)/(y(27)*y(45))));
  g1(22,29)=(-(y(26)*params(47)/(y(27)*y(45))));
  g1(22,38)=1;
  g1(22,45)=(-((-(y(27)*(y(28)*y(25)*params(46)+y(29)*y(26)*params(47))))/(y(27)*y(45)*y(27)*y(45))));
  g1(23,3)=(-(params(41)*T430*params(23)*1/y(43)));
  g1(23,4)=(-(params(41)*T430*params(23)*1/y(43)));
  g1(23,35)=1;
  g1(23,43)=(-(params(41)*T430*params(23)*((-y(3))/(y(43)*y(43))+(-y(4))/(y(43)*y(43)))));
  g1(24,34)=1;
  g1(24,35)=(-1);
  g1(25,25)=(-y(28));
  g1(25,26)=(-y(29));
  g1(25,28)=(-y(25));
  g1(25,29)=(-y(26));
  g1(25,43)=1;
  g1(26,10)=1;
  g1(27,1)=(-(y(21)*(1+y(30))/(1+params(25))-y(21)));
  g1(27,3)=(-((1+y(31))/(1+params(25))-1));
  g1(27,4)=(-((1+y(35))/(1+params(25))-1));
  g1(27,6)=params(30);
  g1(27,7)=params(30);
  g1(27,8)=1;
  g1(27,9)=1;
  g1(27,14)=(-(y(27)*Jimz__+y(14)*y(27)*T720));
  g1(27,20)=1;
  g1(27,21)=(-((1+y(30))*y(1)/(1+params(25))-y(1)));
  g1(27,27)=(-(y(14)*Jimz__));
  g1(27,30)=(-(y(21)*y(1)/(1+params(25))));
  g1(27,31)=(-(y(3)/(1+params(25))-params(14)/(1+params(25))));
  g1(27,35)=(-(y(4)/(1+params(25))));
  g1(27,44)=(-(y(14)*y(27)*T1030));
  g1(27,45)=params(37);
  g1(28,8)=params(31);
  g1(28,39)=1;
  g1(29,6)=(-((-((1-params(31))*y(8)))/((y(6)+y(7))*(y(6)+y(7)))));
  g1(29,7)=(-((-((1-params(31))*y(8)))/((y(6)+y(7))*(y(6)+y(7)))));
  g1(29,8)=(-((1-params(31))/(y(6)+y(7))));
  g1(29,11)=1;
  g1(30,1)=1;
  g1(30,43)=(-((-(x(13)*T939))/(uazuaz__*uazuaz__)+(-(x(14)*T939))/(uazuaz__*uazuaz__)+(-(x(15)*T939))/(uazuaz__*uazuaz__)-(-(x(16)*T939))/(uazuaz__*uazuaz__)-(-(x(17)*T939))/(uazuaz__*uazuaz__)-(-(x(18)*T939))/(uazuaz__*uazuaz__)));
  g1(31,3)=1-1/(1+params(25));
  g1(31,43)=(-((-(x(7)*T939))/(uazuaz__*uazuaz__)+(-(x(8)*T939))/(uazuaz__*uazuaz__)+(-(x(9)*T939))/(uazuaz__*uazuaz__)-(-(x(10)*T939))/(uazuaz__*uazuaz__)-(-(x(11)*T939))/(uazuaz__*uazuaz__)-(-(x(12)*T939))/(uazuaz__*uazuaz__)));
  g1(32,19)=1;
  g1(34,4)=1-1/(1+params(25));
  g1(34,43)=(-((-(x(19)*T939))/(uazuaz__*uazuaz__)+(-(x(20)*T939))/(uazuaz__*uazuaz__)+(-(x(21)*T939))/(uazuaz__*uazuaz__)-(-(x(22)*T939))/(uazuaz__*uazuaz__)-(-(x(23)*T939))/(uazuaz__*uazuaz__)-(-(x(24)*T939))/(uazuaz__*uazuaz__)));
  g1(35,14)=uaz__;
  g1(35,27)=y(14)*params(69)*1/params(44)/y(43);
  g1(35,43)=y(14)*(-(params(69)*y(27)/params(44)))/(y(43)*y(43));
  g1(36,9)=uazuaz__;
  g1(36,43)=y(9)*T939;
  g1(37,20)=uazuaz__;
  g1(37,43)=y(20)*T939;
  g1(38,32)=uazuaz__;
  g1(38,43)=y(32)*T939;
  g1(39,3)=y(31)*1/(1+params(25));
  g1(39,31)=foo__;
  g1(39,43)=(-((-(int_repayment__*T939))/(uazuaz__*uazuaz__)));
  g1(40,26)=1;
  g1(41,23)=1;
  g1(42,24)=1;
  g1(43,25)=(-(1/y(26)));
  g1(43,26)=(-((-y(25))/(y(26)*y(26))));
  g1(43,33)=1;
  g1(44,23)=(-((-y(26))/(y(23)*y(23))));
  g1(44,26)=(-(1/y(23)));
  g1(44,40)=1;
  g1(45,24)=(-((-y(26))/(y(24)*y(24))));
  g1(45,26)=(-(1/y(24)));
  g1(45,41)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],45,2025);
end
end
