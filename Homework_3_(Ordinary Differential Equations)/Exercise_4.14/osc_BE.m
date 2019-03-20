% Created by:   Suraj Jaiswal
% Date:         15.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     4.14: Use a Backward Euler scheme for oscillations

clc; clear; close all;

omega = 2;
P = 2*pi/omega; % period of oscillation
dt_range = [P/20, P/2000]; % assuming 20, and 2000 intervals per period

for ii = 1:length(dt_range)
    dt = dt_range(ii);
    T = 3*P; % total time period
    N_t = floor(T/dt);
    t = linspace(0, N_t*dt, N_t+1);

    u = zeros(N_t+1, 1);
    v = zeros(N_t+1, 1);
    
    % Initial condition
    X_0 = 2;
    u(1) = X_0;
    v(1) = 0;

    % Step equations forward in time
    for n = 1:N_t
        u(n+1) = (u(n) + dt*v(n))/(1+dt^2*omega^2);
        v(n+1) = (v(n) - dt*omega^2*u(n))/(1+dt^2*omega^2);
    end

    % Position plot
    figure(1);
    plot(t, u,':','LineWidth',1);
    grid on;
    grid minor;
    xlabel('time','FontSize',12, 'FontName', 'Times New Roman');
    ylabel('Position for an oscillating 1 DOF system','FontSize',12, 'FontName', 'Times New Roman');
    set(gca,'FontSize',12, 'FontName', 'Times New Roman');
    Legend_1{ii} = ['Numerical solution (time-step = ', num2str(round(dt,4)),')'];
    hold on
end

fig1 = figure(1);
plot(t, X_0*cos(omega*t),'--', 'LineWidth',1); % exact solution plot
Legend_1{3} = 'Exact solution';
legend(Legend_1,'Location','northwest', 'FontSize',12, 'FontName', 'Times New Roman');

print(fig1,'Figure1_Ex3','-depsc')
