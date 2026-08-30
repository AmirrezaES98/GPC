%% Clear Workspace & Figures
clc; clear; close all;

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

%% Run GPC Simulation
result = GPC(setup);      % Execute Generalized Predictive Control

%% Visualization
figure
plot(setup.t, result.yl, 'LineWidth', 1.5, 'Color', 'b');
hold on
plot(setup.t(1:end-1), result.yd, 'LineWidth', 1.5, 'Color', 'g')
plot(setup.t, result.ynl, 'LineWidth', 1.8, 'Color', 'r')
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('System Response', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend('Linear Model', 'Reference', 'Nonlinear Model','FontSize', 14, 'Location', 'best',Interpreter='latex')
title('GPC Performance Comparison', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
grid on

figure
plot(setup.t,result.xl, 'LineWidth', 1.5)
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('Linear states', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend(["$x_1$","$x_2$"],'FontSize', 14, 'Location', 'best',Interpreter='latex')
grid on

figure
plot(setup.t,result.xnl, 'LineWidth', 1.5)
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('NonLinear states', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend(["$x_1$","$x_2$"], 'Location', 'best','FontSize', 14,Interpreter='latex')
grid on

figure
plot(setup.t, result.ul, 'LineWidth', 1.5, 'Color', 'b');
hold on
plot(setup.t, result.unl, 'LineWidth', 1.5, 'Color', 'r')
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('u(t)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend('Linear', 'Nonlinear','FontSize', 14,'Location', 'best',Interpreter='latex')
title('Control signal', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
grid on
%% Optional Analysis Sections (Commented Out)
% Uncomment below sections to investigate different aspects

%% Prediction Horizon Effect Analysis
Prediction_horizon_effect(setup);

%% Control Horizon Tuning
control_horizon_effect(setup);


%% Weighting Factor Study
gamma_effect(setup);

%%
%%Effect of filter
effect_of_filter(setup)
%% Disturbance Response Analysis
disturbance_response(setup);

%% Noise Response Analysis
Noise_effect(setup);

%% Noise and Disterbance effect
Noise_and_disterbance(setup);

%% tracking sinusoidal reference
sinusoidal(setup);

%% different initial condition
different_inital_condition()