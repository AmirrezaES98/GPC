function different_inital_condition()
%% Simulation Time Configuration
setup = struct();
setup.t0 = 0;        % Initial time [s]
setup.tf = 500;      % Final time [s]
setup.Ts = 0.05;     % Sampling time [s]
setup.t = setup.t0:setup.Ts:setup.tf; % Time vector
setup.samples = length(setup.t); % Total number of samples

%% GPC Controller Parameters
setup.gamma = 0.08;  % Controller weighting factor
DCgain = 0.25;       % Direct current gain for noise shaping
setup.q = DCgain^2; 
setup.r = 1;
setup.P = 60;        % Prediction horizon
setup.M = 10;        % Control horizon
setup.alpha = 0;
setup.case = 1;%yd that givne and for seeing traching sin function change 1
                %to 2
%% System Model Definition
% Discrete state-space representation
setup.A = [1, 0.05;-0.1937, 0.99];% State matrix
setup.B = [0; 0.05]; % Input matrix
setup.C = [1, 0];    % Output matrix
setup.d = 2;         % Transport delay [samples]

%% Operating Point Configuration
setup.ustar = 3;     % Steady-state control input
setup.ystar = 0.6589; % Steady-state output

%% Simulation Flags
setup.noise = "off";      % Measurement noise toggle
setup.disterbance = "off"; % Disturbance toggle (note: typo kept for consistency)
%%
%different inital conditions
x0 = cell(1,4);
x0{1} = [0.8;0];
x0{2} = [0.4 ;0];
x0{3} = [-0.4; 0];
x0{4} = [-0.8;0];
%%
%simulation part
yl = cell(1,4);
xl = cell(1,4);
ynl = cell(1,4);
xnl = cell(1,4);
ul = cell(1,4);
unl = cell(1,4);


n = setup.samples-1;
yd = reference(n,setup.alpha);
yd=setup.ystar*yd;
t = (0:n-1)*setup.Ts;
setup.t=t;
setup.samples=n;
for i = 1:4
    X0 = x0{i};
    result = different_initial_GPC(setup,X0);
    yl{i} = result.yl;
    ul{i} = result.ul;
    xl{i} = result.xl;
end

%% Figure 1: Linearized system output
figure('Position', [100 100 900 600])
% Main plot
main_ax = axes;
plot(t,yl{1},LineWidth=1.5,Color='b')
hold on
plot(t,yl{2},LineWidth=1.5,Color='r')
plot(t,yl{3},LineWidth=1.5,Color='g')
plot(t,yl{4},LineWidth=1.5,Color='y')
plot(t,yd,LineWidth=1.5,Color='k')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$\bar x_0=[0.8\quad 0]$","$\bar x_0=[0.4 \quad0]$",...
    "$\bar x_0=[-0.4\quad 0]$","$\bar x_0=[-0.8 \quad0]$","$y_d$"],...
    'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('output','FontSize',18,'Interpreter','latex')
title('Linearized system','FontSize',18,'Interpreter','latex')
grid on

% Inset zoom plot
inset_ax = axes('Position',[0.22 0.62 0.25 0.25]);
box on
plot(t,yl{1},LineWidth=1,Color='b')
hold on
plot(t,yl{2},LineWidth=1,Color='r')
plot(t,yl{3},LineWidth=1,Color='g')
plot(t,yl{4},LineWidth=1,Color='y')
plot(t,yd,LineWidth=1,Color='k')
xlim([0 25])
set(inset_ax,'FontSize',10)
title('Zoom: 0-25 sec','FontSize',10)
grid on

%% Figure 2: Linearized system control input
figure('Position', [100 100 900 600])
% Main plot
main_ax = axes;
plot(t,ul{1},LineWidth=1.5,Color='b')
hold on
plot(t,ul{2},LineWidth=1.5,Color='r')
plot(t,ul{3},LineWidth=1.5,Color='g')
plot(t,ul{4},LineWidth=1.5,Color='y')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$\bar x_0=[0.8\quad 0]$","$\bar x_0=[0.4\quad 0]$",...
    "$\bar x_0=[-0.4\quad 0]$","$\bar x_0=[-0.8 \quad0]$"],...
    'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('$u(t)$','FontSize',18,'Interpreter','latex')
title('Linearized system','FontSize',18,'Interpreter','latex')
grid on

% Inset zoom plot
inset_ax = axes('Position',[0.22 0.62 0.25 0.25]);
box on
plot(t,ul{1},LineWidth=1,Color='b')
hold on
plot(t,ul{2},LineWidth=1,Color='r')
plot(t,ul{3},LineWidth=1,Color='g')
plot(t,ul{4},LineWidth=1,Color='y')
xlim([0 25])
set(inset_ax,'FontSize',10)
title('Zoom: 0-25 sec','FontSize',10)
grid on

%% Nonlinear system initialization
x0 = cell(1,4);
x0{1} = [0.6;0];
x0{2} = [0.65 ;0];
x0{3} = [0.7; 0];
x0{4} = [0.75;0];
for i = 1:4
    X0 = x0{i};
    result = different_initial_GPC(setup,X0);
    ynl{i} = result.ynl;
    unl{i} = result.unl;
    xnl{i} = result.xnl;
end

%% Figure 3: Nonlinear system output
figure('Position', [100 100 900 600])
% Main plot
main_ax = axes;
plot(t,ynl{1},LineWidth=1.5,Color='b')
hold on
plot(t,ynl{2},LineWidth=1.5,Color='r')
plot(t,ynl{3},LineWidth=1.5,Color='g')
plot(t,ynl{4},LineWidth=1.5,Color='y')
plot(t,yd,LineWidth=1.5,Color='k')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$\bar x_0=[0.6\quad 0]$","$\bar x_0=[0.65 \quad0]$",...
    "$\bar x_0=[0.7\quad 0]$","$\bar x_0=[0.75 \quad0]$","$y_d$"],...
    'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('output','FontSize',18,'Interpreter','latex')
title('Nonlinear system','FontSize',18,'Interpreter','latex')
grid on

% Inset zoom plot
inset_ax = axes('Position',[0.22 0.62 0.25 0.25]);
box on
plot(t,ynl{1},LineWidth=1,Color='b')
hold on
plot(t,ynl{2},LineWidth=1,Color='r')
plot(t,ynl{3},LineWidth=1,Color='g')
plot(t,ynl{4},LineWidth=1,Color='y')
plot(t,yd,LineWidth=1,Color='k')
xlim([0 25])
set(inset_ax,'FontSize',10)
title('Zoom: 0-25 sec','FontSize',10)
grid on

%% Figure 4: Nonlinear system control input
figure('Position', [100 100 900 600])
% Main plot
main_ax = axes;
plot(t,unl{1},LineWidth=1.5,Color='b')
hold on
plot(t,unl{2},LineWidth=1.5,Color='r')
plot(t,unl{3},LineWidth=1.5,Color='g')
plot(t,unl{4},LineWidth=1.5,Color='y')
xlabel('Time(sec)','FontSize',18,'Interpreter','latex')
legend(["$\bar x_0=[0.6\quad 0]$","$\bar x_0=[0.65 \quad0]$",...
    "$\bar x_0=[0.7\quad 0]$","$\bar x_0=[0.75 \quad0]$"],...
    'Location', 'best','FontSize',14,'Interpreter','latex')
ylabel('$u(t)$','FontSize',18,'Interpreter','latex')
title('Linearized system','FontSize',18,'Interpreter','latex')
grid on

% Inset zoom plot
inset_ax = axes('Position',[0.22 0.62 0.25 0.25]);
box on
plot(t,unl{1},LineWidth=1,Color='b')
hold on
plot(t,unl{2},LineWidth=1,Color='r')
plot(t,unl{3},LineWidth=1,Color='g')
plot(t,unl{4},LineWidth=1,Color='y')
xlim([0 25])
set(inset_ax,'FontSize',10)
title('Zoom: 0-25 sec','FontSize',10)
grid on

end