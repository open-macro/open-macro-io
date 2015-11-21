shocks;

% ----- Public investment profile -----
var e_iz0; 
periods 1 2  3  4  5  6 7 8; 
values  2.5 3.5 3.5 3.3 2.9 2.5 2.2 2 ;

var e_iz1;
periods 9:1000;
values 1.5;

% ----- Grants profile -----
var e_grants0;
periods 1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30;
values 0.4	0.4	0.4	0.4	0.4	0.4	0.4	0.4	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2;


% ----- Concessional borrowing profile -----
var e_d0; 
periods  1 2 3 4 5 6 7 8;
values  4	5	4	3	2	 1	0.75 0.5;

% ----- Principal repayment on concessional debt -----
var e_d0_neg;
periods 1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30;
values 0	0	0	0	0	0	0	0 1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	0	0	0;

% ----- Tax ceiling -----
var e_hbar0;
periods 1:1000;
values 0.05;

% ----- Transfer floor -----
var e_Tbar0;
periods 1:1000;
values 0;

end;