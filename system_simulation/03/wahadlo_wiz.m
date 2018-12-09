sim('lab3')
m= str2num(get_param('lab3/Subsystem','m'));
l= str2num(get_param('lab3/Subsystem','l'));
l_max = l + max(r);
for i=1:length(fi)
    l2 = l + r(i);
    plot(-l2*sin(fi(i)), -l2*cos(fi(i)), 'b.','MarkerSize',5*m);
    hold on
    plot([0 -l2*sin(fi(i))],[0 -l2*cos(fi(i))],'Color','r','LineWidth',2);
    hold off
    
    axis([-1.1*l_max 1.1*l_max -1.1*l_max 1.1*l_max])
    pause(0.01)
    
end
