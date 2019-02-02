f = [100;200];
A = [5,25;0.5,0;100,250;10,10];
b = [500,15,7500,400];
Aeq = [];
beq = [];
lb = 0;
ub = [];

[x,fval] = linprog(-f,A,b,Aeq,beq,lb,ub);
x = ceil(x);
ceil(fval);

disp('Krzeslo: ')
disp(x(1))
disp('Stol: ')
disp(x(2))
tabela = A * x;
disp('Drewno: ')
drewno = tabela(1);
disp(drewno)
disp('Skora: ')
skora = tabela(2);
disp(skora)
disp('Klej')
klej = tabela(3);
disp(klej)
disp('Naklad pracy')
naklad_pracy =  tabela(4);
disp(naklad_pracy)

disp('Zysk:')
disp(fval)