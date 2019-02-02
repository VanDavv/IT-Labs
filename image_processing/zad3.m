close all
clear all

%x=imread('oko.png');
x=imread('oko2.png');
%x = double(x);

[columns, rows] = size(x);
kat = 315;
d = ceil(sqrt(2));
max_wspol = 256;
m_wspol = zeros(max_wspol);
a = round(cosd(kat)*d);
b = round(sind(kat)*d);

for i = 1+d : columns-d
   for j = d : rows-d
            m_wspol(x(i+a,j+b)+1,x(i,j)+1)= m_wspol(x(i+a,j+b)+1,x(i,j)+1)+1; 
   end   
end
mesh(m_wspol)
ostrosc = sum(diag(m_wspol))/sum(sum(x(:)))
