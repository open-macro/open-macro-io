function [residual, g1, g2, g3] = dig_main_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(45, 1);
Robx__ = params(40)/2*y(7)*(y(27)/y(7)-params(17)-params(25))^2;
Robn__ = params(39)/2*y(6)*(y(26)/y(6)-params(16)-params(25))^2;
compn__ = (1-params(54)-params(53))*y(39)^(-params(21))/(params(53)*y(37)^(1-params(21))+params(54)*y(40)^(1-params(21))+(1-params(54)-params(53))*y(39)^(1-params(21)));
Jimz__ = ((params(25)+params(18))*params(71)+(1+y(28)/y(13)-params(18)-params(25))^params(45)*(y(28)-(params(25)+params(18))*params(71)))/y(28);
DD__ = y(28)*y(41)*Jimz__+(1+y(45))*y(3)/(1+params(25))-y(17)+(1+y(12))*y(4)/(1+params(25))-y(18)+y(35)*(1+y(10))*y(1)/(1+params(25))-y(35)*y(15)+params(65)-(y(20)+y(21))*params(30)-(y(23)+y(34))-y(14)*params(37);
DDo__ = params(65)+params(14)*(y(45)-params(25))/(1+params(25))+params(15)*(params(56)+params(41)-params(25))/(1+params(25))+(params(55)-params(25))*params(12)/(1+params(25))+params(71)*(params(25)+params(18))*params(44)-params(30)*(params(20)+params(19))-(params(29)+params(42))-params(37)*params(70);
h_target__ = params(30)+(1-params(31))*y(22)/(y(20)+y(21));
T_target__ = params(65)-params(31)*y(22);
uazuaz__ = params(69)/y(57);
uaz__ = params(69)*y(41)/params(44)/y(57);
foo__ = y(3)/(1+params(25));
int_repayment__ = x(it_, 73)+x(it_, 74)+x(it_, 75)-x(it_, 76)-x(it_, 77)-x(it_, 78);
T9 = params(40)/2;
T21 = params(39)/2;
T39 = (1-params(54)-params(53))*y(39)^(-params(21));
T47 = params(53)*y(37)^(1-params(21))+params(54)*y(40)^(1-params(21));
T50 = T47+(1-params(54)-params(53))*y(39)^(1-params(21));
T60 = (1+y(28)/y(13)-params(18)-params(25))^params(45);
T74 = params(4)*(y(43)/params(49))^params(63);
T78 = T74*y(14)^params(47);
T82 = y(7)^(params(68)+params(8));
T86 = y(32)^(1-params(8));
T95 = params(2)*(y(42)/params(48))^params(62);
T98 = T95*y(14)^params(46);
T102 = y(6)^(params(67)+params(7));
T106 = y(31)^(1-params(7));
T124 = T47+y(39)^(1-params(21))*(1-params(53)-params(54));
T132 = y(20)/y(35);
T133 = y(60)/y(64)/T132;
T153 = y(36)/y(65);
T154 = (1+y(44))*y(64)/y(35)*T153;
T156 = 1+params(40)*(y(27)/y(7)-params(17)-params(25));
T167 = params(40)*(y(63)/y(30)-params(17)-params(25));
T177 = 1+params(39)*(y(26)/y(6)-params(16)-params(25));
T188 = params(39)*(y(62)/y(29)-params(16)-params(25));
T348 = exp(params(23)*(y(17)/y(57)+y(18)/y(57)-params(14)/params(69)-params(15)/params(69)));
T709 = getPowerDeriv(T133,1/params(64),1);
T741 = 1+T21*y(6)*1/y(6)*2*(y(26)/y(6)-params(16)-params(25));
T762 = 1+T9*y(7)*1/y(7)*2*(y(27)/y(7)-params(17)-params(25));
T778 = getPowerDeriv(1+y(28)/y(13)-params(18)-params(25),params(45),1);
T785 = (y(28)*(T60+(y(28)-(params(25)+params(18))*params(71))*1/y(13)*T778)-((params(25)+params(18))*params(71)+T60*(y(28)-(params(25)+params(18))*params(71))))/(y(28)*y(28));
T809 = T21*(y(26)/y(6)-params(16)-params(25))^2+T21*y(6)*2*(y(26)/y(6)-params(16)-params(25))*(-y(26))/(y(6)*y(6));
T840 = T9*(y(27)/y(7)-params(17)-params(25))^2+T9*y(7)*2*(y(27)/y(7)-params(17)-params(25))*(-y(27))/(y(7)*y(7));
T900 = (1+y(44))*y(64)/y(35)*1/y(65);
T907 = (1+y(44))*y(64)/y(35)*(-y(36))/(y(65)*y(65));
T918 = getPowerDeriv(T124,1/(1-params(21)),1);
T1049 = (-(params(3)/(1+params(3))/(1+y(25))));
T1068 = (-params(69))/(y(57)*y(57));
T1158 = (y(28)-(params(25)+params(18))*params(71))*T778*(-y(28))/(y(13)*y(13))/y(28);
T1181 = 1/uazuaz__;
lhs =y(43);
rhs =T78*T82*T86;
residual(1)= lhs-rhs;
lhs =y(42);
rhs =T98*T102*T106;
residual(2)= lhs-rhs;
lhs =y(36);
rhs =y(38)+y(39)*params(1);
residual(3)= lhs-rhs;
lhs =y(41);
rhs =y(38)+y(39)*params(5);
residual(4)= lhs-rhs;
lhs =y(35);
rhs =T124^(1/(1-params(21)));
residual(5)= lhs-rhs;
lhs =T133^(1/params(64));
rhs =params(11)*(1+y(25))*(1+y(44))/((1+y(61))*(1+params(25)));
residual(6)= lhs-rhs;
lhs =T154*T156;
rhs =y(67)/y(65)+1-params(17)+T167*(1+y(63)/y(30)-params(17))-T9*(y(63)/y(30)-params(17)-params(25))^2;
residual(7)= lhs-rhs;
lhs =T154*T177;
rhs =y(66)/y(65)+1-params(16)+T188*(1+y(62)/y(29)-params(16))-T21*(y(62)/y(29)-params(16)-params(25))^2;
residual(8)= lhs-rhs;
lhs =1+y(48);
rhs =y(64)*(1+y(44))*(1-params(22)*(y(16)-params(13)))/y(35);
residual(9)= lhs-rhs;
lhs =(1+params(25))*y(30);
rhs =y(27)+y(7)*(1-params(17));
residual(10)= lhs-rhs;
lhs =(1+params(25))*y(29);
rhs =y(26)+y(6)*(1-params(16));
residual(11)= lhs-rhs;
lhs =(1+params(25))*y(58);
rhs =y(28)+y(13)*(1-params(18));
residual(12)= lhs-rhs;
lhs =y(59);
rhs =params(71)*params(58)+params(57)*(y(58)-params(71));
residual(13)= lhs-rhs;
lhs =y(42)*y(39)*(1-params(7))/y(31);
rhs =y(56);
residual(14)= lhs-rhs;
lhs =y(43)*y(40)*(1-params(8))/y(32);
rhs =y(56);
residual(15)= lhs-rhs;
lhs =y(42)*y(39)*params(7)/y(6);
rhs =y(50);
residual(16)= lhs-rhs;
lhs =y(43)*y(40)*params(8)/y(7);
rhs =y(51);
residual(17)= lhs-rhs;
lhs =y(42);
rhs =compn__*(y(20)+y(21))+params(1)*(y(27)+y(26)+Robx__+Robn__)+y(28)*params(5)*Jimz__;
residual(18)= lhs-rhs;
lhs =y(32)+y(31);
rhs =(1+params(3))*params(36);
residual(19)= lhs-rhs;
lhs =y(16)+y(17)+y(18);
rhs =y(20)+y(21)+y(36)*(y(27)+y(26)+Robx__+Robn__)+y(28)*y(41)*Jimz__+(1+y(45))*y(3)/(1+params(25))+(1+y(12))*y(4)/(1+params(25))+(1+y(11))*y(2)/(1+params(25))+params(22)/2*(y(16)-params(13))^2-y(39)*y(42)-y(40)*y(43)-(y(23)+y(34))-y(46);
residual(20)= lhs-rhs;
lhs =y(21);
rhs =(params(36)*y(56)*params(3)+params(3)/(1+params(3))*(y(46)+y(53)))/(1+y(25));
residual(21)= lhs-rhs;
lhs =y(52);
rhs =(y(42)*y(39)*params(46)+y(43)*y(40)*params(47))/(y(14)*y(41));
residual(22)= lhs-rhs;
lhs =y(49);
rhs =params(56)+params(41)*T348;
residual(23)= lhs-rhs;
lhs =y(48);
rhs =y(49)+params(38);
residual(24)= lhs-rhs;
lhs =y(57);
rhs =y(39)*y(42)+y(40)*y(43);
residual(25)= lhs-rhs;
lhs =y(24);
rhs =params(25)+(y(42)-y(8))/y(8)+(y(43)-y(9))/y(9);
residual(26)= lhs-rhs;
lhs =y(22);
rhs =DD__-DDo__;
residual(27)= lhs-rhs;
lhs =y(53);
rhs =T_target__;
residual(28)= lhs-rhs;
lhs =y(25);
rhs =h_target__;
residual(29)= lhs-rhs;
lhs =y(15);
rhs =params(12)+x(it_, 13)/uazuaz__+x(it_, 14)/uazuaz__+x(it_, 15)/uazuaz__-x(it_, 16)/uazuaz__-x(it_, 17)/uazuaz__-x(it_, 18)/uazuaz__;
residual(30)= lhs-rhs;
lhs =y(17);
rhs =params(25)*params(14)/(1+params(25))+y(3)/(1+params(25))+x(it_, 7)/uazuaz__+x(it_, 8)/uazuaz__+x(it_, 9)/uazuaz__-x(it_, 10)/uazuaz__-x(it_, 11)/uazuaz__-x(it_, 12)/uazuaz__;
residual(31)= lhs-rhs;
lhs =y(33);
rhs =x(it_, 9)+x(it_, 7)+x(it_, 8)-x(it_, 10)-x(it_, 11)-x(it_, 12);
residual(32)= lhs-rhs;
lhs =y(19);
rhs =x(it_, 9)+x(it_, 7)+x(it_, 8)-x(it_, 10)-x(it_, 11)-x(it_, 12)+y(5);
residual(33)= lhs-rhs;
lhs =y(18);
rhs =x(it_, 19)/uazuaz__+x(it_, 20)/uazuaz__+x(it_, 21)/uazuaz__-x(it_, 22)/uazuaz__-x(it_, 23)/uazuaz__-x(it_, 24)/uazuaz__+y(4)/(1+params(25));
residual(34)= lhs-rhs;
lhs =y(28)*uaz__;
rhs =(params(25)+params(18))*params(71)+x(it_, 1)+x(it_, 2)+x(it_, 3)-x(it_, 4)-x(it_, 5)-x(it_, 6);
residual(35)= lhs-rhs;
lhs =y(23)*uazuaz__;
rhs =params(29)+x(it_, 25)+x(it_, 26)+x(it_, 27)-x(it_, 28)-x(it_, 29)-x(it_, 30);
residual(36)= lhs-rhs;
lhs =y(34)*uazuaz__;
rhs =params(42)+x(it_, 31)+x(it_, 32)+x(it_, 33)-x(it_, 34)-x(it_, 35)-x(it_, 36);
residual(37)= lhs-rhs;
lhs =y(46)*uazuaz__;
rhs =params(52)+x(it_, 37)+x(it_, 38)+x(it_, 39)-x(it_, 40)-x(it_, 41)-x(it_, 42);
residual(38)= lhs-rhs;
lhs =y(45)*foo__;
rhs =int_repayment__/uazuaz__;
residual(39)= lhs-rhs;
lhs =y(40);
rhs =1+x(it_, 55)+x(it_, 56)+x(it_, 57)-x(it_, 58)-x(it_, 59)-x(it_, 60);
residual(40)= lhs-rhs;
lhs =y(37);
rhs =1+x(it_, 61)+x(it_, 62)+x(it_, 63)-x(it_, 64)-x(it_, 65)-x(it_, 66);
residual(41)= lhs-rhs;
lhs =y(38);
rhs =1+x(it_, 67)+x(it_, 68)+x(it_, 69)-x(it_, 70)-x(it_, 71)-x(it_, 72);
residual(42)= lhs-rhs;
lhs =y(47);
rhs =y(39)/y(40);
residual(43)= lhs-rhs;
lhs =y(54);
rhs =y(40)/y(37);
residual(44)= lhs-rhs;
lhs =y(55);
rhs =y(40)/y(38);
residual(45)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(45, 145);

  %
  % Jacobian matrix
  %

  g1(1,7)=(-(T86*T78*getPowerDeriv(y(7),params(68)+params(8),1)));
  g1(1,32)=(-(T78*T82*getPowerDeriv(y(32),1-params(8),1)));
  g1(1,43)=1-T86*T82*y(14)^params(47)*params(4)*1/params(49)*getPowerDeriv(y(43)/params(49),params(63),1);
  g1(1,14)=(-(T86*T82*T74*getPowerDeriv(y(14),params(47),1)));
  g1(2,6)=(-(T106*T98*getPowerDeriv(y(6),params(67)+params(7),1)));
  g1(2,31)=(-(T98*T102*getPowerDeriv(y(31),1-params(7),1)));
  g1(2,42)=1-T106*T102*y(14)^params(46)*params(2)*1/params(48)*getPowerDeriv(y(42)/params(48),params(62),1);
  g1(2,14)=(-(T106*T102*T95*getPowerDeriv(y(14),params(46),1)));
  g1(3,36)=1;
  g1(3,38)=(-1);
  g1(3,39)=(-params(1));
  g1(4,38)=(-1);
  g1(4,39)=(-params(5));
  g1(4,41)=1;
  g1(5,35)=1;
  g1(5,37)=(-(params(53)*getPowerDeriv(y(37),1-params(21),1)*T918));
  g1(5,39)=(-(T918*(1-params(53)-params(54))*getPowerDeriv(y(39),1-params(21),1)));
  g1(5,40)=(-(T918*params(54)*getPowerDeriv(y(40),1-params(21),1)));
  g1(6,20)=(-(y(60)/y(64)*1/y(35)))/(T132*T132)*T709;
  g1(6,60)=T709*1/y(64)/T132;
  g1(6,25)=(-(params(11)*(1+y(44))/((1+y(61))*(1+params(25)))));
  g1(6,61)=(-((-(params(11)*(1+y(25))*(1+y(44))*(1+params(25))))/((1+y(61))*(1+params(25))*(1+y(61))*(1+params(25)))));
  g1(6,35)=T709*(-(y(60)/y(64)*(-y(20))/(y(35)*y(35))))/(T132*T132);
  g1(6,64)=T709*(-y(60))/(y(64)*y(64))/T132;
  g1(6,44)=(-(params(11)*(1+y(25))/((1+y(61))*(1+params(25)))));
  g1(7,27)=T154*params(40)*1/y(7);
  g1(7,63)=(-((1+y(63)/y(30)-params(17))*params(40)*1/y(30)+T167*1/y(30)-T9*1/y(30)*2*(y(63)/y(30)-params(17)-params(25))));
  g1(7,7)=T154*params(40)*(-y(27))/(y(7)*y(7));
  g1(7,30)=(-((1+y(63)/y(30)-params(17))*params(40)*(-y(63))/(y(30)*y(30))+T167*(-y(63))/(y(30)*y(30))-T9*2*(y(63)/y(30)-params(17)-params(25))*(-y(63))/(y(30)*y(30))));
  g1(7,35)=T156*T153*(1+y(44))*(-y(64))/(y(35)*y(35));
  g1(7,64)=T156*T153*(1+y(44))*1/y(35);
  g1(7,36)=T156*T900;
  g1(7,65)=T156*T907-(-y(67))/(y(65)*y(65));
  g1(7,44)=T156*y(64)/y(35)*T153;
  g1(7,67)=(-(1/y(65)));
  g1(8,26)=T154*params(39)*1/y(6);
  g1(8,62)=(-((1+y(62)/y(29)-params(16))*params(39)*1/y(29)+T188*1/y(29)-T21*1/y(29)*2*(y(62)/y(29)-params(16)-params(25))));
  g1(8,6)=T154*params(39)*(-y(26))/(y(6)*y(6));
  g1(8,29)=(-((1+y(62)/y(29)-params(16))*params(39)*(-y(62))/(y(29)*y(29))+T188*(-y(62))/(y(29)*y(29))-T21*2*(y(62)/y(29)-params(16)-params(25))*(-y(62))/(y(29)*y(29))));
  g1(8,35)=T177*T153*(1+y(44))*(-y(64))/(y(35)*y(35));
  g1(8,64)=T177*T153*(1+y(44))*1/y(35);
  g1(8,36)=T177*T900;
  g1(8,65)=T177*T907-(-y(66))/(y(65)*y(65));
  g1(8,44)=T177*y(64)/y(35)*T153;
  g1(8,66)=(-(1/y(65)));
  g1(9,16)=(-(y(64)*(1+y(44))*(-params(22))/y(35)));
  g1(9,35)=(-((-(y(64)*(1+y(44))*(1-params(22)*(y(16)-params(13)))))/(y(35)*y(35))));
  g1(9,64)=(-((1+y(44))*(1-params(22)*(y(16)-params(13)))/y(35)));
  g1(9,44)=(-(y(64)*(1-params(22)*(y(16)-params(13)))/y(35)));
  g1(9,48)=1;
  g1(10,27)=(-1);
  g1(10,7)=(-(1-params(17)));
  g1(10,30)=1+params(25);
  g1(11,26)=(-1);
  g1(11,6)=(-(1-params(16)));
  g1(11,29)=1+params(25);
  g1(12,28)=(-1);
  g1(12,13)=(-(1-params(18)));
  g1(12,58)=1+params(25);
  g1(13,58)=(-params(57));
  g1(13,59)=1;
  g1(14,31)=(-(y(42)*y(39)*(1-params(7))))/(y(31)*y(31));
  g1(14,39)=y(42)*(1-params(7))/y(31);
  g1(14,42)=y(39)*(1-params(7))/y(31);
  g1(14,56)=(-1);
  g1(15,32)=(-(y(43)*y(40)*(1-params(8))))/(y(32)*y(32));
  g1(15,40)=y(43)*(1-params(8))/y(32);
  g1(15,43)=y(40)*(1-params(8))/y(32);
  g1(15,56)=(-1);
  g1(16,6)=(-(y(42)*y(39)*params(7)))/(y(6)*y(6));
  g1(16,39)=y(42)*params(7)/y(6);
  g1(16,42)=y(39)*params(7)/y(6);
  g1(16,50)=(-1);
  g1(17,7)=(-(y(43)*y(40)*params(8)))/(y(7)*y(7));
  g1(17,40)=y(43)*params(8)/y(7);
  g1(17,43)=y(40)*params(8)/y(7);
  g1(17,51)=(-1);
  g1(18,20)=(-compn__);
  g1(18,21)=(-compn__);
  g1(18,26)=(-(params(1)*T741));
  g1(18,27)=(-(params(1)*T762));
  g1(18,28)=(-(params(5)*Jimz__+y(28)*params(5)*T785));
  g1(18,6)=(-(params(1)*T809));
  g1(18,7)=(-(params(1)*T840));
  g1(18,37)=(-((y(20)+y(21))*(-(T39*params(53)*getPowerDeriv(y(37),1-params(21),1)))/(T50*T50)));
  g1(18,39)=(-((y(20)+y(21))*(T50*(1-params(54)-params(53))*getPowerDeriv(y(39),(-params(21)),1)-T39*(1-params(54)-params(53))*getPowerDeriv(y(39),1-params(21),1))/(T50*T50)));
  g1(18,40)=(-((y(20)+y(21))*(-(T39*params(54)*getPowerDeriv(y(40),1-params(21),1)))/(T50*T50)));
  g1(18,42)=1;
  g1(18,13)=(-(y(28)*params(5)*T1158));
  g1(19,31)=1;
  g1(19,32)=1;
  g1(20,2)=(-((1+y(11))/(1+params(25))));
  g1(20,16)=1-params(22)/2*2*(y(16)-params(13));
  g1(20,3)=(-((1+y(45))/(1+params(25))));
  g1(20,17)=1;
  g1(20,4)=(-((1+y(12))/(1+params(25))));
  g1(20,18)=1;
  g1(20,20)=(-1);
  g1(20,21)=(-1);
  g1(20,23)=1;
  g1(20,26)=(-(y(36)*T741));
  g1(20,27)=(-(y(36)*T762));
  g1(20,28)=(-(y(41)*Jimz__+y(28)*y(41)*T785));
  g1(20,6)=(-(y(36)*T809));
  g1(20,7)=(-(y(36)*T840));
  g1(20,34)=1;
  g1(20,36)=(-(y(27)+y(26)+Robx__+Robn__));
  g1(20,39)=y(42);
  g1(20,40)=y(43);
  g1(20,41)=(-(y(28)*Jimz__));
  g1(20,42)=y(39);
  g1(20,43)=y(40);
  g1(20,45)=(-(y(3)/(1+params(25))));
  g1(20,46)=1;
  g1(20,11)=(-(y(2)/(1+params(25))));
  g1(20,12)=(-(y(4)/(1+params(25))));
  g1(20,13)=(-(y(28)*y(41)*T1158));
  g1(21,21)=1;
  g1(21,25)=(-((-(params(36)*y(56)*params(3)+params(3)/(1+params(3))*(y(46)+y(53))))/((1+y(25))*(1+y(25)))));
  g1(21,46)=T1049;
  g1(21,53)=T1049;
  g1(21,56)=(-(params(3)*params(36)/(1+y(25))));
  g1(22,39)=(-(y(42)*params(46)/(y(14)*y(41))));
  g1(22,40)=(-(y(43)*params(47)/(y(14)*y(41))));
  g1(22,41)=(-((-(y(14)*(y(42)*y(39)*params(46)+y(43)*y(40)*params(47))))/(y(14)*y(41)*y(14)*y(41))));
  g1(22,42)=(-(y(39)*params(46)/(y(14)*y(41))));
  g1(22,43)=(-(y(40)*params(47)/(y(14)*y(41))));
  g1(22,52)=1;
  g1(22,14)=(-((-(y(41)*(y(42)*y(39)*params(46)+y(43)*y(40)*params(47))))/(y(14)*y(41)*y(14)*y(41))));
  g1(23,17)=(-(params(41)*T348*params(23)*1/y(57)));
  g1(23,18)=(-(params(41)*T348*params(23)*1/y(57)));
  g1(23,49)=1;
  g1(23,57)=(-(params(41)*T348*params(23)*((-y(17))/(y(57)*y(57))+(-y(18))/(y(57)*y(57)))));
  g1(24,48)=1;
  g1(24,49)=(-1);
  g1(25,39)=(-y(42));
  g1(25,40)=(-y(43));
  g1(25,42)=(-y(39));
  g1(25,43)=(-y(40));
  g1(25,57)=1;
  g1(26,24)=1;
  g1(26,8)=(-(((-y(8))-(y(42)-y(8)))/(y(8)*y(8))));
  g1(26,42)=(-(1/y(8)));
  g1(26,9)=(-(((-y(9))-(y(43)-y(9)))/(y(9)*y(9))));
  g1(26,43)=(-(1/y(9)));
  g1(27,1)=(-(y(35)*(1+y(10))/(1+params(25))));
  g1(27,15)=y(35);
  g1(27,3)=(-((1+y(45))/(1+params(25))));
  g1(27,17)=1;
  g1(27,4)=(-((1+y(12))/(1+params(25))));
  g1(27,18)=1;
  g1(27,20)=params(30);
  g1(27,21)=params(30);
  g1(27,22)=1;
  g1(27,23)=1;
  g1(27,28)=(-(y(41)*Jimz__+y(28)*y(41)*T785));
  g1(27,34)=1;
  g1(27,35)=(-((1+y(10))*y(1)/(1+params(25))-y(15)));
  g1(27,41)=(-(y(28)*Jimz__));
  g1(27,10)=(-(y(35)*y(1)/(1+params(25))));
  g1(27,45)=(-(y(3)/(1+params(25))-params(14)/(1+params(25))));
  g1(27,12)=(-(y(4)/(1+params(25))));
  g1(27,13)=(-(y(28)*y(41)*T1158));
  g1(27,14)=params(37);
  g1(28,22)=params(31);
  g1(28,53)=1;
  g1(29,20)=(-((-((1-params(31))*y(22)))/((y(20)+y(21))*(y(20)+y(21)))));
  g1(29,21)=(-((-((1-params(31))*y(22)))/((y(20)+y(21))*(y(20)+y(21)))));
  g1(29,22)=(-((1-params(31))/(y(20)+y(21))));
  g1(29,25)=1;
  g1(30,15)=1;
  g1(30,57)=(-((-(x(it_, 13)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 14)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 15)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 16)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 17)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 18)*T1068))/(uazuaz__*uazuaz__)));
  g1(30,80)=(-T1181);
  g1(30,81)=(-T1181);
  g1(30,82)=(-T1181);
  g1(30,83)=T1181;
  g1(30,84)=T1181;
  g1(30,85)=T1181;
  g1(31,3)=(-(1/(1+params(25))));
  g1(31,17)=1;
  g1(31,57)=(-((-(x(it_, 7)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 8)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 9)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 10)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 11)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 12)*T1068))/(uazuaz__*uazuaz__)));
  g1(31,74)=(-T1181);
  g1(31,75)=(-T1181);
  g1(31,76)=(-T1181);
  g1(31,77)=T1181;
  g1(31,78)=T1181;
  g1(31,79)=T1181;
  g1(32,33)=1;
  g1(32,74)=(-1);
  g1(32,75)=(-1);
  g1(32,76)=(-1);
  g1(32,77)=1;
  g1(32,78)=1;
  g1(32,79)=1;
  g1(33,5)=(-1);
  g1(33,19)=1;
  g1(33,74)=(-1);
  g1(33,75)=(-1);
  g1(33,76)=(-1);
  g1(33,77)=1;
  g1(33,78)=1;
  g1(33,79)=1;
  g1(34,4)=(-(1/(1+params(25))));
  g1(34,18)=1;
  g1(34,57)=(-((-(x(it_, 19)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 20)*T1068))/(uazuaz__*uazuaz__)+(-(x(it_, 21)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 22)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 23)*T1068))/(uazuaz__*uazuaz__)-(-(x(it_, 24)*T1068))/(uazuaz__*uazuaz__)));
  g1(34,86)=(-T1181);
  g1(34,87)=(-T1181);
  g1(34,88)=(-T1181);
  g1(34,89)=T1181;
  g1(34,90)=T1181;
  g1(34,91)=T1181;
  g1(35,28)=uaz__;
  g1(35,41)=y(28)*params(69)*1/params(44)/y(57);
  g1(35,57)=y(28)*(-(params(69)*y(41)/params(44)))/(y(57)*y(57));
  g1(35,68)=(-1);
  g1(35,69)=(-1);
  g1(35,70)=(-1);
  g1(35,71)=1;
  g1(35,72)=1;
  g1(35,73)=1;
  g1(36,23)=uazuaz__;
  g1(36,57)=y(23)*T1068;
  g1(36,92)=(-1);
  g1(36,93)=(-1);
  g1(36,94)=(-1);
  g1(36,95)=1;
  g1(36,96)=1;
  g1(36,97)=1;
  g1(37,34)=uazuaz__;
  g1(37,57)=y(34)*T1068;
  g1(37,98)=(-1);
  g1(37,99)=(-1);
  g1(37,100)=(-1);
  g1(37,101)=1;
  g1(37,102)=1;
  g1(37,103)=1;
  g1(38,46)=uazuaz__;
  g1(38,57)=y(46)*T1068;
  g1(38,104)=(-1);
  g1(38,105)=(-1);
  g1(38,106)=(-1);
  g1(38,107)=1;
  g1(38,108)=1;
  g1(38,109)=1;
  g1(39,3)=y(45)*1/(1+params(25));
  g1(39,45)=foo__;
  g1(39,57)=(-((-(int_repayment__*T1068))/(uazuaz__*uazuaz__)));
  g1(39,140)=(-T1181);
  g1(39,141)=(-T1181);
  g1(39,142)=(-T1181);
  g1(39,143)=(-((-1)/uazuaz__));
  g1(39,144)=(-((-1)/uazuaz__));
  g1(39,145)=(-((-1)/uazuaz__));
  g1(40,40)=1;
  g1(40,122)=(-1);
  g1(40,123)=(-1);
  g1(40,124)=(-1);
  g1(40,125)=1;
  g1(40,126)=1;
  g1(40,127)=1;
  g1(41,37)=1;
  g1(41,128)=(-1);
  g1(41,129)=(-1);
  g1(41,130)=(-1);
  g1(41,131)=1;
  g1(41,132)=1;
  g1(41,133)=1;
  g1(42,38)=1;
  g1(42,134)=(-1);
  g1(42,135)=(-1);
  g1(42,136)=(-1);
  g1(42,137)=1;
  g1(42,138)=1;
  g1(42,139)=1;
  g1(43,39)=(-(1/y(40)));
  g1(43,40)=(-((-y(39))/(y(40)*y(40))));
  g1(43,47)=1;
  g1(44,37)=(-((-y(40))/(y(37)*y(37))));
  g1(44,40)=(-(1/y(37)));
  g1(44,54)=1;
  g1(45,38)=(-((-y(40))/(y(38)*y(38))));
  g1(45,40)=(-(1/y(38)));
  g1(45,55)=1;
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],45,21025);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],45,3048625);
end
end
