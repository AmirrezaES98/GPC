function Prediction_horizon_effect(setup)
%effect of different perediction horizon
P = [30 40 50 60];
yl = cell(1,length(P));
xl = cell(1,length(P));
ynl = cell(1,length(P));
xnl = cell(1,length(P));
ul = cell(1,length(P));
unl = cell(1,length(P));


n = setup.samples-1;
yd = reference(n,setup.alpha);
yd=setup.ystar*yd;
t = (0:n-1)*setup.Ts;
setup.t=t;
setup.samples=n;
for i = 1:length(P)
    setup.P =P(i);
    result = GPC(setup);
    yl{i} = result.yl;
    ul{i} = result.ul;
    xl{i} = result.xl;
end
figure
plot(t,yl{1},LineWidth=1.5,Color='b')
hold on
plot(t,yl{2},LineWidth=1.5,Color='r')
plot(t,yl{3},LineWidth=1.5,Color='g')
plot(t,yl{4},LineWidth=1.5,Color='y')
plot(t,yd,LineWidth=1.5,Color='k')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$p=30$","$p=40$","$p=50$","$p=60$","$y_d$"], 'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('output','FontSize',18,'Interpreter','latex')
title('Linearized system','FontSize',18,'Interpreter','latex')
grid on

figure
plot(t,ul{1},LineWidth=1.5,Color='b')
hold on
plot(t,ul{2},LineWidth=1.5,Color='r')
plot(t,ul{3},LineWidth=1.5,Color='g')
plot(t,ul{4},LineWidth=1.5,Color='y')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$p=30$","$p=40$","$p=50$","$p=60$"], 'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('$u(t)$','FontSize',18,'Interpreter','latex')
title('Linearized system','FontSize',18,'Interpreter','latex')
grid on
for i = 1:length(P)
    setup.P =P(i);
    result = GPC(setup);
    ynl{i} = result.ynl;
    unl{i} = result.unl;
    xnl{i} = result.xnl;
end
figure
plot(t,ynl{1},LineWidth=1.5,Color='b')
hold on
plot(t,ynl{2},LineWidth=1.5,Color='r')
plot(t,ynl{3},LineWidth=1.5,Color='g')
plot(t,ynl{4},LineWidth=1.5,Color='y')
plot(t,yd,LineWidth=1.5,Color='k')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$p=30$","$p=40$","$p=50$","$p=60$","$y_d$"], 'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('output','FontSize',18,'Interpreter','latex')
title('Nonlinear system','FontSize',18,'Interpreter','latex')
grid on

figure
plot(t,unl{1},LineWidth=1.5,Color='b')
hold on
plot(t,unl{2},LineWidth=1.5,Color='r')
plot(t,unl{3},LineWidth=1.5,Color='g')
plot(t,unl{4},LineWidth=1.5,Color='y')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$p=30$","$p=40$","$p=50$","$p=60$"], 'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('$u(t)$','FontSize',18,'Interpreter','latex')
title('Nonlinearized system','FontSize',18,'Interpreter','latex')
grid on
end