shocks;

% ----- Public investment profile -----
var shock0_iz; 
periods 1 2  3  4  5  6 7 8; 
values  2.5 3.5 3.5 3.3 2.9 2.5 2.2 2 ;

var shock1_iz;
periods 9:1000;
values 1.5;

% ----- Grants profile -----
var shock0_grants;
periods 1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30;
values 0.4	0.4	0.4	0.4	0.4	0.4	0.4	0.4	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2	0.2;


% ----- Concessional borrowing profile -----
var shock0_d; 
periods  1 2 3 4 5 6 7 8;
values  4	5	4	3	2	 1	0.75 0.5;

% ----- Principal repayment on concessional debt -----
var shockneg0_d;
periods 1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30;
values 0	0	0	0	0	0	0	0 1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	1.0125	0	0	0;

% ----- Remittances profile -----
var remit;
periods 1:1000;
values 4; % needs to equal "remito"

var px;
periods 1:5;
values 1;

var pm;
periods 1:5;
values 1;

var shock0_hbar;
periods 8:1000;
values 0.02;

end;