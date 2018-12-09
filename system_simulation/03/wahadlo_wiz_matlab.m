sim('lab3')
m= str2num(get_param('lab3/Subsystem','m'));
l= str2num(get_param('lab3/Subsystem','l'));
l_max = l + max(r);
l2 = l + r(1);
ne = 10; a = 1; ro = 0.2;
[xs,ys] = spring(0,0,0 -l2*sin(fi(1)),0 -l2*cos(fi(1)),ne,a,ro); plot(xs,ys,'LineWidth',2)

for i=1:length(fi)
    l2 = l + r(i);
    [xs,ys] = spring(0,0,0 -l2*sin(fi(i)),0 -l2*cos(fi(i))); 
    plot(xs,ys,'LineWidth',2)
    
    axis([-1.1*l_max 1.1*l_max -1.1*l_max 1.1*l_max])
    pause(0.01)
    
end
