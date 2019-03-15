% Created by:   Suraj Jaiswal
% Date:         15.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     4.4: Find an appropriate time step; logistic model

clc; clear; close all;

M = 500; % Maximum population
r_bar = 0.1; % Growth rate constant
N_0 = 100; % Initial population
dt = 20; % Initial value of the time-step
T = 100; % Time period in months

f = @(N, t) r_bar*(1 - N/M)*N; % function to be computed
[u_old, t_old] = ode_FE(f, N_0, dt, T);

k = 1;
compute = true;

while compute == true
    dt_k = dt/2^k;
    [u_new, t_new] = ode_FE(f, N_0, dt_k, T);
    
    bluediff = [0, 0.4470, 0.7410]; % blue color for plotting
    orangediff = [0.8500, 0.3250, 0.0980]; % orange color for plotting
    
    figure(1)
    plot(t_old, u_old, '-', 'LineWidth',1,'Color',orangediff);
    hold on;
    plot(t_new, u_new, '--', 'LineWidth',1.5,'Color',bluediff);
    grid on;
    grid minor;
    xlabel('time (months)','FontSize',12, 'FontName', 'Times New Roman');
    ylabel('Population (individuals)','FontSize',12, 'FontName', 'Times New Roman');
    set(gca,'FontSize',12, 'FontName', 'Times New Roman');
    Legend{1} = ['Solution for time-step = ', num2str(dt)];
    Legend{2} = ['Solution for time-step = ', num2str(dt_k)];
    legend(Legend,'Location','southeast', 'FontSize',12, 'FontName', 'Times New Roman');
    print('Figure1','-depsc')
    
    user_2 = input('Can you figure out the difference between two plots?(y/n): ','s');
    close all;
    if user_2 == 'y'
        u_old = u_new;
        t_old = t_new;
        dt = dt_k;
    else
        compute = false;
    end
    k = k+1;
end

fprintf('The sufficient time-step for the problem at hand is: %d\n', dt);
