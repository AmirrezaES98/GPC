function result = GPC(setup)
result = struct();
ypast= setup.ystar*ones(setup.P,1);
n = setup.samples-1;
ul = zeros(1,setup.samples);
xl = zeros(2,setup.samples);
yl = zeros(1,setup.samples);
if setup.case == 1
    yd = setup.ystar*reference(n,setup.alpha);
    yd = yd';
elseif setup.case == 2
    x = 0:setup.Ts:setup.tf;
    x = 1.3*sin(0.05*x);
    yd = x(1:n);
    yd = yd';
end
sys = ss(setup.A, setup.B, setup.C, 0, setup.Ts);
g = step(sys, setup.t);
g = g(1+setup.d:setup.P+setup.d);
G = toeplitz(g, [g(1), zeros(1, setup.M-1)]);
Q = setup.gamma*setup.q*eye(setup.P);  % Output weighting
R = setup.r*eye(setup.M);       % Control move weighting
KGPC = (G'*Q*G + R) \ (G'*Q);
k = KGPC(1,:);
result.yd = yd;
if setup.disterbance == "on"
    result.D = [zeros(1,n/2) 0.3*ones(1,n/2)];
else
    result.D = zeros(1,setup.samples);
end
if setup.noise =="on"
    w = wgn(1,n,-40);
else
    w = zeros(1,n);
end
for i = 1:setup.samples-1-setup.P
    E = yd(i:i+setup.P-1)-ypast;
    du = k*E;
    ul(i+1) = du + ul(i);
    xl(:,i+1) = setup.A*xl(:,i)+setup.B*ul(i)+[1;1]*w(i);
    y = setup.C*xl(:,i+1)+setup.ystar+result.D(i);
    yl(i) =  y;
    ypast = [y;ypast(1:end-1)];
end
unl = zeros(1,setup.samples);
xnl = zeros(2,setup.samples);
ynl = zeros(1,setup.samples);
ypast= setup.ystar*ones(setup.P,1);
xnl(:,1) = [setup.ystar;0];
for i = 1:setup.samples-1-setup.P
    E = yd(i:i+setup.P-1)-ypast;
    dun = k*E;
    unl(i+1) = dun + unl(i);
    [ynl(i),xnl(:,i+1)] = nonlinearsystem(xnl(:,i),unl(i)+setup.ustar,w(i),result.D(i));
    ypast = [ynl(i);ypast(1:end-1)];
end
result.xl = xl;
result.ul = ul;
result.yl = yl;
result.xnl = xnl;
result.unl = unl;
result.ynl = ynl;
end