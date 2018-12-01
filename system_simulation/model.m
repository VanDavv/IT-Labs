sim('lab1');
R = str2num(get_param('lab1/Subsystem', 'R'));



RS = str2num(get_param('lab1/Subsystem', 'RS'));

for i=1:length(xarray)
    x = xarray(i)
    y = yarray(i)
    plot(xarray(1:i), yarray(1:i))
    rectangle('Position', [0-R, 0-R, 2*R, 2*R], 'Curvature', [1 1]);
    rectangle('Position', [x-RS, y-RS, 2*RS, 2*RS], 'Curvature', [1 1]);
%     rectangle(0-R, 0-R, 2*R, 2*R)
%     rectangle(x-RS, x-RS, 2*RS, 2*RS)
    axis([-10 10 -10 10])
    daspect([1 1 1])
    pause(2^-7)
end