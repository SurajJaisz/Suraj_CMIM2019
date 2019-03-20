% Created by:   Suraj Jaiswal
% Date:         15.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     4.10: Compute the energy in oscillations

clc; clear; close all;

omega = 2;
P = 2*pi/omega; % period of oscillation
dt_range = [P/40, P/160, P/5000]; % assuming 40, 160, and 5000 intervals per period

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
        u(n+1) = u(n) + dt*v(n);
        v(n+1) = v(n) - dt*omega^2*u(n);
        [PE, KE] = osc_energy(u, v, omega); % energy calculation
        TE = PE + KE; % total energy
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
    
    % Energy plot
    fig2 = figure(2);
    plot(t, TE,'-', 'LineWidth',1);
    hold on;
    grid on;
    grid minor;
    xlabel('time','FontSize',12, 'FontName', 'Times New Roman');
    ylabel('Total energy for an oscillating 1 DOF system','FontSize',12, 'FontName', 'Times New Roman');
    set(gca,'FontSize',12, 'FontName', 'Times New Roman');
    hold on
    Legend_2{ii} = ['Total energy (time-step = ', num2str(round(dt,4)),')'];
    legend(Legend_2,'Location','northwest', 'FontSize',12, 'FontName', 'Times New Roman');
    
end

fig1 = figure(1);
plot(t, X_0*cos(omega*t),'--', 'LineWidth',1); % exact solution plot
Legend_1{4} = 'Exact solution';
legend(Legend_1,'Location','northwest', 'FontSize',12, 'FontName', 'Times New Roman');

print(fig1,'Figure1_Ex2','-depsc')
print(fig2,'Figure2_Ex2','-depsc')

