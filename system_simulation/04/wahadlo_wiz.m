sim('lab4')
m= str2num(get_param('lab4/Subsystem','m'));
l_max = max(r);
for i=1:length(f)
    l2 = r(i);
    plot(-l2*sin(f(i)), -l2*cos(f(i)), 'b.','MarkerSize',5*m);
    hold on
    plot([0 -l2*sin(f(i))],[0 -l2*cos(f(i))],'Color','r','LineWidth',2);
    hold off
    
    axis([-1.1*l_max 1.1*l_max -1.1*l_max 1.1*l_max])
    pause(0.01)
    
end
