axis equal;
XMIN = 0;
XMAX = 3;
YMIN = 0;
YMAX = 3;
ZMIN = 0;
ZMAX = 3;
axis([XMIN, XMAX, YMIN, YMAX, ZMIN, ZMAX]);
rotate3d on;
grid on;
zlabel('z')
ylabel('y')
xlabel('x')

hold on;


x = eye(4);
x = x * trans(1,1,2);
plotframe(x, 1, 'a')