function disturbance_response(setup)
setup.disterbance = "on"; % Activate disturbance
result = GPC(setup);      % Execute Generalized Predictive Control
figure
plot(setup.t, result.yl, 'LineWidth', 1.5, 'Color', 'b');
hold on
plot(setup.t(1:end-1), result.yd, 'LineWidth', 1.5, 'Color', 'r')
hold on 
plot(setup.t(1:end-1), result.D, 'LineWidth', 1.5, 'Color', 'g')
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('$y(t)$', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend('Linear Model', 'Reference', 'Disterbance','FontSize', 14, 'Location', 'best',Interpreter='latex')
title('Linearized system', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
grid on

figure
plot(setup.t, result.ynl, 'LineWidth', 1.5, 'Color', 'b');
hold on
plot(setup.t(1:end-1), result.yd, 'LineWidth', 1.5, 'Color', 'r')
hold on 
plot(setup.t(1:end-1), result.D, 'LineWidth', 1.5, 'Color', 'g')
xlabel('Time (sec)', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
ylabel('$y(t)$', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
legend('Nonlinear Model', 'Reference', 'Disterbance','FontSize', 14, 'Location', 'best',Interpreter='latex')
title('Nonlinear system', 'FontSize', 18, 'FontWeight', 'bold',Interpreter='latex')
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