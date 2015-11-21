function [residual, g1, g2, g3] = dsf_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(39, 1);
ACx__ = y(6)*params(42)/2*(y(22)/y(6)-params(17)-params(25))^2;
ACn__ = y(5)*params(41)/2*(y(21)/y(5)-params(16)-params(25))^2;
abcap__ = (params(76)*(params(25)+params(18))+(1+y(23)/y(10)-params(18)-params(25))^params(47)*(y(23)-params(76)*(params(25)+params(18))))/y(23);
compn__ = (1-params(56)-params(55))*y(31)^(-params(21))/(params(55)*y(34)^(1-params(21))+params(56)*y(33)^(1-params(21))+y(31)^(1-params(21))*(1-params(56)-params(55)));
DD__ = y(23)*y(32)*abcap__+(1+y(39))*y(3)/(1+params(25))-y(14)+params(38)*(1+y(9))*y(4)/(1+params(25))-params(38)*y(15)+y(29)*(1+y(7))*y(1)/(1+params(25))-y(29)*y(12)+params(70)-(y(16)+y(17))*params(31)-(y(19)+y(28))-y(11)*params(39);
DDo__ = params(70)+params(14)*(y(39)-params(25))/(1+params(25))+params(15)*params(38)*(params(58)+params(43)-params(25))/(1+params(25))+(params(57)-params(25))*params(12)/(1+params(25))+params(76)*(params(25)+params(18))*params(46)-params(31)*(params(20)+params(19))-(params(29)+params(44))-params(39)*params(75);
h_target__ = params(31)+y(18)*(1-params(32))/(y(16)+y(17));
T_target__ = params(70)-y(18)*params(32);
uazuaz__ = params(74)/y(48);
uaz_b__ = y(29)*params(74)/y(48);
uaz__ = params(74)*y(32)/params(46)/y(48);
T14 = params(4)*(y(37)/params(51))^params(65);
T18 = T14*y(11)^params(49);
T23 = y(6)^(params(73)+params(8));
T27 = y(27)^(1-params(8));
T36 = params(2)*(y(36)/params(50))^params(64);
T39 = T36*y(11)^params(48);
T44 = y(5)^(params(72)+params(7));
T48 = y(26)^(1-params(7));
T74 = params(55)*y(34)^(1-params(21))+params(56)*y(33)^(1-params(21));
T79 = T74+(1-params(55)-params(56))*y(31)^(1-params(21));
T87 = y(16)/y(29);
T88 = y(51)/y(55)/T87;
T109 = y(30)/y(56);
T110 = (1+y(38))*y(55)/y(29)*T109;
T118 = 1+params(42)*(y(22)/y(6)-params(17)-params(25));
T129 = params(42)*(y(54)/y(25)-params(17)-params(25));
T134 = params(42)/2;
T146 = 1+params(41)*(y(21)/y(5)-params(16)-params(25));
T157 = params(41)*(y(53)/y(24)-params(16)-params(25));
T162 = params(41)/2;
T235 = (1+y(23)/y(10)-params(18)-params(25))^params(47);
T246 = (1-params(56)-params(55))*y(31)^(-params(21));
T248 = T74+y(31)^(1-params(21))*(1-params(56)-params(55));
T352 = exp(params(23)*(y(14)/y(48)+params(38)*y(15)/y(48)-params(14)/params(74)-params(38)*params(15)/params(74)));
T450 = params(74)/y(48);
T661 = getPowerDeriv(T88,1/params(66),1);
T693 = 1+y(5)*T162*1/y(5)*2*(y(21)/y(5)-params(16)-params(25));
T714 = 1+y(6)*T134*1/y(6)*2*(y(22)/y(6)-params(17)-params(25));
T730 = getPowerDeriv(1+y(23)/y(10)-params(18)-params(25),params(47),1);
T737 = (y(23)*(T235+(y(23)-params(76)*(params(25)+params(18)))*1/y(10)*T730)-(params(76)*(params(25)+params(18))+T235*(y(23)-params(76)*(params(25)+params(18)))))/(y(23)*y(23));
T761 = T162*(y(21)/y(5)-params(16)-params(25))^2+y(5)*T162*2*(y(21)/y(5)-params(16)-params(25))*(-y(21))/(y(5)*y(5));
T792 = T134*(y(22)/y(6)-params(17)-params(25))^2+y(6)*T134*2*(y(22)/y(6)-params(17)-params(25))*(-y(22))/(y(6)*y(6));
T877 = (1+y(38))*y(55)/y(29)*1/y(56);
T884 = (1+y(38))*y(55)/y(29)*(-y(30))/(y(56)*y(56));
T897 = getPowerDeriv(T79,1/(1-params(21)),1);
T1001 = (-(params(3)/(1+params(3))/(1+y(20))));
T1022 = (-params(74))/(y(48)*y(48));
T1049 = (-(y(29)*params(74)))/(y(48)*y(48));
T1110 = (y(23)-params(76)*(params(25)+params(18)))*T730*(-y(23))/(y(10)*y(10))/y(23);
T1137 = 1/uazuaz__;
T1139 = 1/uaz_b__;
lhs =y(37);
rhs =T18*T23*T27;
residual(1)= lhs-rhs;
lhs =y(36);
rhs =T39*T44*T48;
residual(2)= lhs-rhs;
lhs =y(30);
rhs =y(35)+params(1)*y(31);
residual(3)= lhs-rhs;
lhs =y(32);
rhs =y(35)+y(31)*params(5);
residual(4)= lhs-rhs;
lhs =y(29);
rhs =T79^(1/(1-params(21)));
residual(5)= lhs-rhs;
lhs =T88^(1/params(66));
rhs =params(11)*(1+y(20))*(1+y(38))/((1+y(52))*(1+params(25)));
residual(6)= lhs-rhs;
lhs =T110*T118;
rhs =y(58)/y(56)+1-params(17)+T129*(1+y(54)/y(25)-params(17))-T134*(y(54)/y(25)-params(17)-params(25))^2;
residual(7)= lhs-rhs;
lhs =T110*T146;
rhs =y(57)/y(56)+1-params(16)+T157*(1+y(53)/y(24)-params(16))-T162*(y(53)/y(24)-params(16)-params(25))^2;
residual(8)= lhs-rhs;
lhs =1+y(41);
rhs =y(55)*(1+y(38))*(1-params(22)*(y(13)-params(13)))/y(29);
residual(9)= lhs-rhs;
lhs =(1+params(25))*y(25);
rhs =y(22)+y(6)*(1-params(17));
residual(10)= lhs-rhs;
lhs =(1+params(25))*y(24);
rhs =y(21)+y(5)*(1-params(16));
residual(11)= lhs-rhs;
lhs =(1+params(25))*y(49);
rhs =y(23)+(1-params(18))*y(10);
residual(12)= lhs-rhs;
lhs =y(50);
rhs =params(60)*params(76)+params(59)*(y(49)-params(76));
residual(13)= lhs-rhs;
lhs =y(36)*(1-params(7))*y(31)/y(26);
rhs =y(47);
residual(14)= lhs-rhs;
lhs =y(37)*(1-params(8))*y(33)/y(27);
rhs =y(47);
residual(15)= lhs-rhs;
lhs =y(36)*params(7)*y(31)/y(5);
rhs =y(43);
residual(16)= lhs-rhs;
lhs =y(37)*params(8)*y(33)/y(6);
rhs =y(44);
residual(17)= lhs-rhs;
lhs =y(36);
rhs =compn__*(y(16)+y(17))+params(1)*(y(22)+y(21)+ACx__+ACn__)+y(23)*params(5)*abcap__;
residual(18)= lhs-rhs;
lhs =y(27)+y(26);
rhs =(1+params(3))*params(37);
residual(19)= lhs-rhs;
lhs =y(13)+y(14)+params(38)*y(15);
rhs =y(16)+y(17)+y(30)*(y(22)+y(21)+ACx__+ACn__)+y(23)*y(32)*abcap__+(1+y(39))*y(3)/(1+params(25))+params(38)*(1+y(9))*y(4)/(1+params(25))+(1+y(8))*y(2)/(1+params(25))+params(22)/2*(y(13)-params(13))^2-y(36)*y(31)-y(37)*y(33)-(y(19)+y(28))-y(40);
residual(20)= lhs-rhs;
lhs =y(17);
rhs =(params(37)*y(47)*params(3)+params(3)/(1+params(3))*(y(40)+y(46)))/(1+y(20));
residual(21)= lhs-rhs;
lhs =y(45);
rhs =(y(36)*params(48)*y(31)+y(37)*params(49)*y(33))/(y(11)*y(32));
residual(22)= lhs-rhs;
lhs =y(42);
rhs =params(58)+params(43)*T352;
residual(23)= lhs-rhs;
lhs =y(41);
rhs =y(42)+params(40);
residual(24)= lhs-rhs;
lhs =y(48);
rhs =y(36)*y(31)+y(37)*y(33);
residual(25)= lhs-rhs;
lhs =y(18);
rhs =DD__-DDo__;
residual(26)= lhs-rhs;
lhs =y(46);
rhs =T_target__;
residual(27)= lhs-rhs;
lhs =y(20);
rhs =h_target__;
residual(28)= lhs-rhs;
lhs =y(14);
rhs =params(25)*params(14)/(1+params(25))+y(3)/(1+params(25))+x(it_, 7)/uazuaz__+x(it_, 8)/uazuaz__+x(it_, 9)/uazuaz__-x(it_, 10)/uazuaz__-x(it_, 11)/uazuaz__-x(it_, 12)/uazuaz__;
residual(29)= lhs-rhs;
lhs =y(12);
rhs =params(25)*params(12)/(1+params(25))+y(1)/(1+params(25))+x(it_, 19)/uaz_b__+x(it_, 20)/uaz_b__+x(it_, 21)/uaz_b__-x(it_, 22)/uaz_b__-x(it_, 23)/uaz_b__-x(it_, 24)/uaz_b__;
residual(30)= lhs-rhs;
lhs =y(15);
rhs =params(25)*params(15)/(1+params(25))+y(4)/(1+params(25))+x(it_, 13)/uazuaz__+x(it_, 14)/uazuaz__+x(it_, 15)/uazuaz__-x(it_, 16)/uazuaz__-x(it_, 17)/uazuaz__-x(it_, 18)/uazuaz__;
residual(31)= lhs-rhs;
lhs =y(23)*uaz__;
rhs =params(76)*(params(25)+params(18))+(x(it_, 1)+x(it_, 2)+x(it_, 3)-x(it_, 4)-x(it_, 5)-x(it_, 6))/y(32);
residual(32)= lhs-rhs;
lhs =y(19)*uazuaz__;
rhs =params(29)+x(it_, 25)+x(it_, 26)+x(it_, 27)-x(it_, 28)-x(it_, 29)-x(it_, 30);
residual(33)= lhs-rhs;
lhs =y(28)*uazuaz__;
rhs =params(44)+x(it_, 31)+x(it_, 32)+x(it_, 33)-x(it_, 34)-x(it_, 35)-x(it_, 36);
residual(34)= lhs-rhs;
lhs =y(40)*uazuaz__;
rhs =params(54)+x(it_, 37)+x(it_, 38)+x(it_, 39)-x(it_, 40)-x(it_, 41)-x(it_, 42);
residual(35)= lhs-rhs;
residual(36) = y(39);
lhs =y(33);
rhs =1+x(it_, 55)+x(it_, 56)+x(it_, 57)-x(it_, 58)-x(it_, 59)-x(it_, 60);
residual(37)= lhs-rhs;
lhs =y(34);
rhs =1+x(it_, 61)+x(it_, 62)+x(it_, 63)-x(it_, 64)-x(it_, 65)-x(it_, 66);
residual(38)= lhs-rhs;
lhs =y(35);
rhs =1+x(it_, 67)+x(it_, 68)+x(it_, 69)-x(it_, 70)-x(it_, 71)-x(it_, 72);
residual(39)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(39, 130);

  %
  % Jacobian matrix
  %

  g1(1,6)=(-(T27*T18*getPowerDeriv(y(6),params(73)+params(8),1)));
  g1(1,27)=(-(T18*T23*getPowerDeriv(y(27),1-params(8),1)));
  g1(1,37)=1-T27*T23*y(11)^params(49)*params(4)*1/params(51)*getPowerDeriv(y(37)/params(51),params(65),1);
  g1(1,11)=(-(T27*T23*T14*getPowerDeriv(y(11),params(49),1)));
  g1(2,5)=(-(T48*T39*getPowerDeriv(y(5),params(72)+params(7),1)));
  g1(2,26)=(-(T39*T44*getPowerDeriv(y(26),1-params(7),1)));
  g1(2,36)=1-T48*T44*y(11)^params(48)*params(2)*1/params(50)*getPowerDeriv(y(36)/params(50),params(64),1);
  g1(2,11)=(-(T48*T44*T36*getPowerDeriv(y(11),params(48),1)));
  g1(3,30)=1;
  g1(3,31)=(-params(1));
  g1(3,35)=(-1);
  g1(4,31)=(-params(5));
  g1(4,32)=1;
  g1(4,35)=(-1);
  g1(5,29)=1;
  g1(5,31)=(-((1-params(55)-params(56))*getPowerDeriv(y(31),1-params(21),1)*T897));
  g1(5,33)=(-(T897*params(56)*getPowerDeriv(y(33),1-params(21),1)));
  g1(5,34)=(-(T897*params(55)*getPowerDeriv(y(34),1-params(21),1)));
  g1(6,16)=(-(y(51)/y(55)*1/y(29)))/(T87*T87)*T661;
  g1(6,51)=T661*1/y(55)/T87;
  g1(6,20)=(-(params(11)*(1+y(38))/((1+y(52))*(1+params(25)))));
  g1(6,52)=(-((-(params(11)*(1+y(20))*(1+y(38))*(1+params(25))))/((1+y(52))*(1+params(25))*(1+y(52))*(1+params(25)))));
  g1(6,29)=T661*(-(y(51)/y(55)*(-y(16))/(y(29)*y(29))))/(T87*T87);
  g1(6,55)=T661*(-y(51))/(y(55)*y(55))/T87;
  g1(6,38)=(-(params(11)*(1+y(20))/((1+y(52))*(1+params(25)))));
  g1(7,22)=T110*params(42)*1/y(6);
  g1(7,54)=(-((1+y(54)/y(25)-params(17))*params(42)*1/y(25)+T129*1/y(25)-T134*1/y(25)*2*(y(54)/y(25)-params(17)-params(25))));
  g1(7,6)=T110*params(42)*(-y(22))/(y(6)*y(6));
  g1(7,25)=(-((1+y(54)/y(25)-params(17))*params(42)*(-y(54))/(y(25)*y(25))+T129*(-y(54))/(y(25)*y(25))-T134*2*(y(54)/y(25)-params(17)-params(25))*(-y(54))/(y(25)*y(25))));
  g1(7,29)=T118*T109*(1+y(38))*(-y(55))/(y(29)*y(29));
  g1(7,55)=T118*T109*(1+y(38))*1/y(29);
  g1(7,30)=T118*T877;
  g1(7,56)=T118*T884-(-y(58))/(y(56)*y(56));
  g1(7,38)=T118*y(55)/y(29)*T109;
  g1(7,58)=(-(1/y(56)));
  g1(8,21)=T110*params(41)*1/y(5);
  g1(8,53)=(-((1+y(53)/y(24)-params(16))*params(41)*1/y(24)+T157*1/y(24)-T162*1/y(24)*2*(y(53)/y(24)-params(16)-params(25))));
  g1(8,5)=T110*params(41)*(-y(21))/(y(5)*y(5));
  g1(8,24)=(-((1+y(53)/y(24)-params(16))*params(41)*(-y(53))/(y(24)*y(24))+T157*(-y(53))/(y(24)*y(24))-T162*2*(y(53)/y(24)-params(16)-params(25))*(-y(53))/(y(24)*y(24))));
  g1(8,29)=T146*T109*(1+y(38))*(-y(55))/(y(29)*y(29));
  g1(8,55)=T146*T109*(1+y(38))*1/y(29);
  g1(8,30)=T146*T877;
  g1(8,56)=T146*T884-(-y(57))/(y(56)*y(56));
  g1(8,38)=T146*y(55)/y(29)*T109;
  g1(8,57)=(-(1/y(56)));
  g1(9,13)=(-(y(55)*(1+y(38))*(-params(22))/y(29)));
  g1(9,29)=(-((-(y(55)*(1+y(38))*(1-params(22)*(y(13)-params(13)))))/(y(29)*y(29))));
  g1(9,55)=(-((1+y(38))*(1-params(22)*(y(13)-params(13)))/y(29)));
  g1(9,38)=(-(y(55)*(1-params(22)*(y(13)-params(13)))/y(29)));
  g1(9,41)=1;
  g1(10,22)=(-1);
  g1(10,6)=(-(1-params(17)));
  g1(10,25)=1+params(25);
  g1(11,21)=(-1);
  g1(11,5)=(-(1-params(16)));
  g1(11,24)=1+params(25);
  g1(12,23)=(-1);
  g1(12,10)=(-(1-params(18)));
  g1(12,49)=1+params(25);
  g1(13,49)=(-params(59));
  g1(13,50)=1;
  g1(14,26)=(-(y(36)*(1-params(7))*y(31)))/(y(26)*y(26));
  g1(14,31)=y(36)*(1-params(7))/y(26);
  g1(14,36)=(1-params(7))*y(31)/y(26);
  g1(14,47)=(-1);
  g1(15,27)=(-(y(37)*(1-params(8))*y(33)))/(y(27)*y(27));
  g1(15,33)=y(37)*(1-params(8))/y(27);
  g1(15,37)=(1-params(8))*y(33)/y(27);
  g1(15,47)=(-1);
  g1(16,5)=(-(y(36)*params(7)*y(31)))/(y(5)*y(5));
  g1(16,31)=y(36)*params(7)/y(5);
  g1(16,36)=params(7)*y(31)/y(5);
  g1(16,43)=(-1);
  g1(17,6)=(-(y(37)*params(8)*y(33)))/(y(6)*y(6));
  g1(17,33)=y(37)*params(8)/y(6);
  g1(17,37)=params(8)*y(33)/y(6);
  g1(17,44)=(-1);
  g1(18,16)=(-compn__);
  g1(18,17)=(-compn__);
  g1(18,21)=(-(params(1)*T693));
  g1(18,22)=(-(params(1)*T714));
  g1(18,23)=(-(params(5)*abcap__+y(23)*params(5)*T737));
  g1(18,5)=(-(params(1)*T761));
  g1(18,6)=(-(params(1)*T792));
  g1(18,31)=(-((y(16)+y(17))*(T248*(1-params(56)-params(55))*getPowerDeriv(y(31),(-params(21)),1)-T246*(1-params(56)-params(55))*getPowerDeriv(y(31),1-params(21),1))/(T248*T248)));
  g1(18,33)=(-((y(16)+y(17))*(-(T246*params(56)*getPowerDeriv(y(33),1-params(21),1)))/(T248*T248)));
  g1(18,34)=(-((y(16)+y(17))*(-(T246*params(55)*getPowerDeriv(y(34),1-params(21),1)))/(T248*T248)));
  g1(18,36)=1;
  g1(18,10)=(-(y(23)*params(5)*T1110));
  g1(19,26)=1;
  g1(19,27)=1;
  g1(20,2)=(-((1+y(8))/(1+params(25))));
  g1(20,13)=1-params(22)/2*2*(y(13)-params(13));
  g1(20,3)=(-((1+y(39))/(1+params(25))));
  g1(20,14)=1;
  g1(20,4)=(-(params(38)*(1+y(9))/(1+params(25))));
  g1(20,15)=params(38);
  g1(20,16)=(-1);
  g1(20,17)=(-1);
  g1(20,19)=1;
  g1(20,21)=(-(y(30)*T693));
  g1(20,22)=(-(y(30)*T714));
  g1(20,23)=(-(y(32)*abcap__+y(23)*y(32)*T737));
  g1(20,5)=(-(y(30)*T761));
  g1(20,6)=(-(y(30)*T792));
  g1(20,28)=1;
  g1(20,30)=(-(y(22)+y(21)+ACx__+ACn__));
  g1(20,31)=y(36);
  g1(20,32)=(-(y(23)*abcap__));
  g1(20,33)=y(37);
  g1(20,36)=y(31);
  g1(20,37)=y(33);
  g1(20,39)=(-(y(3)/(1+params(25))));
  g1(20,40)=1;
  g1(20,8)=(-(y(2)/(1+params(25))));
  g1(20,9)=(-(params(38)*y(4)/(1+params(25))));
  g1(20,10)=(-(y(23)*y(32)*T1110));
  g1(21,17)=1;
  g1(21,20)=(-((-(params(37)*y(47)*params(3)+params(3)/(1+params(3))*(y(40)+y(46))))/((1+y(20))*(1+y(20)))));
  g1(21,40)=T1001;
  g1(21,46)=T1001;
  g1(21,47)=(-(params(3)*params(37)/(1+y(20))));
  g1(22,31)=(-(y(36)*params(48)/(y(11)*y(32))));
  g1(22,32)=(-((-(y(11)*(y(36)*params(48)*y(31)+y(37)*params(49)*y(33))))/(y(11)*y(32)*y(11)*y(32))));
  g1(22,33)=(-(y(37)*params(49)/(y(11)*y(32))));
  g1(22,36)=(-(params(48)*y(31)/(y(11)*y(32))));
  g1(22,37)=(-(params(49)*y(33)/(y(11)*y(32))));
  g1(22,45)=1;
  g1(22,11)=(-((-(y(32)*(y(36)*params(48)*y(31)+y(37)*params(49)*y(33))))/(y(11)*y(32)*y(11)*y(32))));
  g1(23,14)=(-(params(43)*T352*params(23)*1/y(48)));
  g1(23,15)=(-(params(43)*T352*params(23)*params(38)/y(48)));
  g1(23,42)=1;
  g1(23,48)=(-(params(43)*T352*params(23)*((-y(14))/(y(48)*y(48))+(-(params(38)*y(15)))/(y(48)*y(48)))));
  g1(24,41)=1;
  g1(24,42)=(-1);
  g1(25,31)=(-y(36));
  g1(25,33)=(-y(37));
  g1(25,36)=(-y(31));
  g1(25,37)=(-y(33));
  g1(25,48)=1;
  g1(26,1)=(-(y(29)*(1+y(7))/(1+params(25))));
  g1(26,12)=y(29);
  g1(26,3)=(-((1+y(39))/(1+params(25))));
  g1(26,14)=1;
  g1(26,4)=(-(params(38)*(1+y(9))/(1+params(25))));
  g1(26,15)=params(38);
  g1(26,16)=params(31);
  g1(26,17)=params(31);
  g1(26,18)=1;
  g1(26,19)=1;
  g1(26,23)=(-(y(32)*abcap__+y(23)*y(32)*T737));
  g1(26,28)=1;
  g1(26,29)=(-((1+y(7))*y(1)/(1+params(25))-y(12)));
  g1(26,32)=(-(y(23)*abcap__));
  g1(26,7)=(-(y(29)*y(1)/(1+params(25))));
  g1(26,39)=(-(y(3)/(1+params(25))-params(14)/(1+params(25))));
  g1(26,9)=(-(params(38)*y(4)/(1+params(25))));
  g1(26,10)=(-(y(23)*y(32)*T1110));
  g1(26,11)=params(39);
  g1(27,18)=params(32);
  g1(27,46)=1;
  g1(28,16)=(-((-(y(18)*(1-params(32))))/((y(16)+y(17))*(y(16)+y(17)))));
  g1(28,17)=(-((-(y(18)*(1-params(32))))/((y(16)+y(17))*(y(16)+y(17)))));
  g1(28,18)=(-((1-params(32))/(y(16)+y(17))));
  g1(28,20)=1;
  g1(29,3)=(-(1/(1+params(25))));
  g1(29,14)=1;
  g1(29,48)=(-((-(x(it_, 7)*T1022))/(uazuaz__*uazuaz__)+(-(x(it_, 8)*T1022))/(uazuaz__*uazuaz__)+(-(x(it_, 9)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 10)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 11)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 12)*T1022))/(uazuaz__*uazuaz__)));
  g1(29,65)=(-T1137);
  g1(29,66)=(-T1137);
  g1(29,67)=(-T1137);
  g1(29,68)=T1137;
  g1(29,69)=T1137;
  g1(29,70)=T1137;
  g1(30,1)=(-(1/(1+params(25))));
  g1(30,12)=1;
  g1(30,29)=(-((-(T450*x(it_, 19)))/(uaz_b__*uaz_b__)+(-(T450*x(it_, 20)))/(uaz_b__*uaz_b__)+(-(T450*x(it_, 21)))/(uaz_b__*uaz_b__)-(-(T450*x(it_, 22)))/(uaz_b__*uaz_b__)-(-(T450*x(it_, 23)))/(uaz_b__*uaz_b__)-(-(T450*x(it_, 24)))/(uaz_b__*uaz_b__)));
  g1(30,48)=(-((-(x(it_, 19)*T1049))/(uaz_b__*uaz_b__)+(-(x(it_, 20)*T1049))/(uaz_b__*uaz_b__)+(-(x(it_, 21)*T1049))/(uaz_b__*uaz_b__)-(-(x(it_, 22)*T1049))/(uaz_b__*uaz_b__)-(-(x(it_, 23)*T1049))/(uaz_b__*uaz_b__)-(-(x(it_, 24)*T1049))/(uaz_b__*uaz_b__)));
  g1(30,77)=(-T1139);
  g1(30,78)=(-T1139);
  g1(30,79)=(-T1139);
  g1(30,80)=T1139;
  g1(30,81)=T1139;
  g1(30,82)=T1139;
  g1(31,4)=(-(1/(1+params(25))));
  g1(31,15)=1;
  g1(31,48)=(-((-(x(it_, 13)*T1022))/(uazuaz__*uazuaz__)+(-(x(it_, 14)*T1022))/(uazuaz__*uazuaz__)+(-(x(it_, 15)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 16)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 17)*T1022))/(uazuaz__*uazuaz__)-(-(x(it_, 18)*T1022))/(uazuaz__*uazuaz__)));
  g1(31,71)=(-T1137);
  g1(31,72)=(-T1137);
  g1(31,73)=(-T1137);
  g1(31,74)=T1137;
  g1(31,75)=T1137;
  g1(31,76)=T1137;
  g1(32,23)=uaz__;
  g1(32,32)=y(23)*params(74)*1/params(46)/y(48)-(-(x(it_, 1)+x(it_, 2)+x(it_, 3)-x(it_, 4)-x(it_, 5)-x(it_, 6)))/(y(32)*y(32));
  g1(32,48)=y(23)*(-(params(74)*y(32)/params(46)))/(y(48)*y(48));
  g1(32,59)=(-(1/y(32)));
  g1(32,60)=(-(1/y(32)));
  g1(32,61)=(-(1/y(32)));
  g1(32,62)=(-((-1)/y(32)));
  g1(32,63)=(-((-1)/y(32)));
  g1(32,64)=(-((-1)/y(32)));
  g1(33,19)=uazuaz__;
  g1(33,48)=y(19)*T1022;
  g1(33,83)=(-1);
  g1(33,84)=(-1);
  g1(33,85)=(-1);
  g1(33,86)=1;
  g1(33,87)=1;
  g1(33,88)=1;
  g1(34,28)=uazuaz__;
  g1(34,48)=y(28)*T1022;
  g1(34,89)=(-1);
  g1(34,90)=(-1);
  g1(34,91)=(-1);
  g1(34,92)=1;
  g1(34,93)=1;
  g1(34,94)=1;
  g1(35,40)=uazuaz__;
  g1(35,48)=y(40)*T1022;
  g1(35,95)=(-1);
  g1(35,96)=(-1);
  g1(35,97)=(-1);
  g1(35,98)=1;
  g1(35,99)=1;
  g1(35,100)=1;
  g1(36,39)=1;
  g1(37,33)=1;
  g1(37,113)=(-1);
  g1(37,114)=(-1);
  g1(37,115)=(-1);
  g1(37,116)=1;
  g1(37,117)=1;
  g1(37,118)=1;
  g1(38,34)=1;
  g1(38,119)=(-1);
  g1(38,120)=(-1);
  g1(38,121)=(-1);
  g1(38,122)=1;
  g1(38,123)=1;
  g1(38,124)=1;
  g1(39,35)=1;
  g1(39,125)=(-1);
  g1(39,126)=(-1);
  g1(39,127)=(-1);
  g1(39,128)=1;
  g1(39,129)=1;
  g1(39,130)=1;
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],39,16900);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],39,2197000);
end
end
