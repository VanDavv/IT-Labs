f = [2,1.5,3];
A = [4,6,15;2,2,0;5,3,4;7,3,12];
b = [250,60,100,220];
Aeq = [];
beq = [];
lb = 0;
ub = [];

[x,fval] = linprog(f,-A,-b,Aeq,beq,lb,ub);
x = ceil(x);
fval = f * x;

disp('Kanapki: ')
disp(x(1))
disp('Pierogi: ')
disp(x(2))
disp('Slodycze')
disp(x(3))
tabela = A * x;
disp('Bialko: ')
bialko = tabela(1);
disp(bialko)
disp('Tluszcz: ')
tluszcz = tabela(2);
disp(tluszcz)
disp('Witaminy')
witaminy = tabela(3);
disp(witaminy)
disp('Weglowodany')
weglowodany =  tabela(4);
disp(weglowodany)

disp('Koszt diety:')
disp(fval)
