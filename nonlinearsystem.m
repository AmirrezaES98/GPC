function [y,x_new] = nonlinearsystem(x_old,u,w,D)
x_new(1) = x_old(1)+0.05*x_old(2)+w;
x_new(2) = -0.245*sin(x_old(1))+0.99*x_old(2)+0.05*u+w;
x_new=x_new';
y =x_new(1)+D;
end