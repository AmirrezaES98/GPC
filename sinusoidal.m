function sinusoidal(setup)
%% Run GPC Simulation
setup.case = 2;
result = GPC(setup);      % Execute Generalized Predictive Control
figure
plot(setup.t, result.yl, 'LineWidth', 1.5, 'Color', 'b');
hold on
plot(setup.t(1:end-1), result.yd, 'LineWidth', 1.5, 'Color', 'g','LineStyle','--')
hold on 
grid on
plot(setup.t, result.ynl, 'LineWidth', 1.5, 'Color', 'r');
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('System Response', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend('Linear Model', 'Reference','Nonlinear',...
    'FontSize', 14, 'Location', 'best',Interpreter='latex')
title('GPC Performance Comparison', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
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
end