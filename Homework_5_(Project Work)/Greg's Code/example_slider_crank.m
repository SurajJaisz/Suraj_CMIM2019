% Created by:   Suraj Jaiswal
% Date:         14.04.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Slider Crank Mechanism Analysis

close all; clear; clc;

% Slider crank kinematic analysis
%% Coordinates
% ground
q1 = [0; 0; 0];
% crank
q2 = [-0.1 * cosd(30);
       0.1 * sind(30);
      -deg2rad(30)];
% link
h_B = 0.2 * sind(30); % y coordinate of point B
phi_l = asin(h_B / 0.5); % link's angle
q3 = [-0.2 * cosd(30) - 0.3 * cos(phi_l);
       h_B - 0.3 * sin(phi_l);
       phi_l];
% slider
q4 = [-0.2 * cosd(30) - 0.5 * cos(phi_l)
       0
       0];

q_0 = [q1; q2; q3; q4]; % initial coordinates

%% We need two constraint types (geometric ones)
% - revolute
% - simple constraints

%% Revolute joints
% 1 connects ground and crank
revolute(1).i = 1;
revolute(1).j = 2;
revolute(1).s_i = [0; 0];
revolute(1).s_j = [0.1; 0];

% 2 connects crank and link
revolute(2).i = 2;
revolute(2).j = 3;
revolute(2).s_i = [-0.1; 0];
revolute(2).s_j = [0.3; 0];

% 3 connects link and slider
revolute(3).i = 3;
revolute(3).j = 4;
revolute(3).s_i = [-0.2; 0];
revolute(3).s_j = [0; 0];

% % Check revolute joint constraints
% r = revolute(3);
% C_r_i = revolute_joint(r.i, r.j, r.s_i, r.s_j, q_0)

%% Simple constraints

% Three simple joints to fix the ground origin
simple(1).i = 1;
simple(1).k = 1;
simple(1).c_k = 0;

simple(2).i = 1;
simple(2).k = 2;
simple(2).c_k = 0;

simple(3).i = 1;
simple(3).k = 3;
simple(3).c_k = 0;

% slider - use simple joints instead of translational
simple(4).i = 4;
simple(4).k = 2;
simple(4).c_k = 0;

simple(5).i = 4;
simple(5).k = 3;
simple(5).c_k = 0;

% % check simple constraints
% for s = simple
%     C_s_i = simple_joint(s.i, s.k, s.c_k, q_0)
% end

%% Add some driving constraints
driving.i = 2;
driving.k = 3;
driving.d_k = @(t) -pi/6 - 1.2 * t;
driving.d_k_t = @(t) -1.2;
driving.d_k_tt = @(t) 0;

% % Verify
% d = driving(1);
% C_d_i = driving_joint(d.i, d.k, d.d_k, 0, q_0)

% %% Verify constraint function
% clc
% C = constraint(revolute, simple, driving, 0, q_0)

%% Solve constraint equation using fsolve
C_fun = @(t, q) constraint(revolute, simple, driving, t, q);
[T, Q] = position_fsolve(C_fun, 1, q_0, 0.1);

%% Some verification plots
% figure(1)
% plot(Q(:, 4), Q(:, 5), ...
%     Q(:, 7), Q(:, 8), ...
%     Q(:, 10), Q(:, 11), ...
%     0, 0, '*', 'LineWidth', 2);
% axis equal

%% Jacobian of our constraints
Cq = constraint_dq(revolute, simple, driving, 0, q_0);

%% Solve constraint equation using NR
C_fun = @(t, q) constraint(revolute, simple, driving, t, q);
Cq_fun = @(t, q) constraint_dq(revolute, simple, driving, t, q);
[T, Q] = position_NR(C_fun, Cq_fun, 1, q_0, 0.1);

%% Some verification plots
% plot(Q(:, 4), Q(:, 5), ...
%     Q(:, 7), Q(:, 8), ...
%     Q(:, 10), Q(:, 11), ...
%     0, 0, '*', 'LineWidth', 2);
% axis equal

%% Verify Ct
Ct = constraint_dt(revolute, simple, driving, 0, q_0);

%% Solve constraint equation using NR for position and velocity
C_fun = @(t, q) constraint(revolute, simple, driving, t, q);
Cq_fun = @(t, q) constraint_dq(revolute, simple, driving, t, q);
Ct_fun = @(t, q) constraint_dt(revolute, simple, driving, t, q);
[T, Q, QP] = pos_vel_NR(C_fun, Cq_fun, Ct_fun, 1, q_0, 0.1);

%% Some verification plots
figure(2)
plot(Q(:, 4), Q(:, 5), ...
    Q(:, 7), Q(:, 8), ...
    Q(:, 10), Q(:, 11), ...
    0, 0, '*', 'LineWidth', 2);
axis equal
grid on;
grid minor;
xlabel('Position, ${q_x}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
ylabel('Position, ${q_y}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
legend({'Crank','Connection rod','Slider','Origin'},'FontSize',12, 'FontName', 'Times New Roman', 'location', 'best')
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure1_Position_SliderCrankMechanism','-depsc')


%% Some verification plots
figure(3)
plot(QP(:, 4), QP(:, 5), ...
    QP(:, 7), QP(:, 8), ...
    QP(:, 10), QP(:, 11), ...
    0, 0, '*', 'LineWidth', 2);
axis equal
grid on;
grid minor;
xlabel('Velocity, ${{\dot{q}}_x}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
ylabel('Velocity, ${{\dot{q}}_y}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
legend({'Crank','Connection rod','Slider','Origin'},'FontSize',12, 'FontName', 'Times New Roman', 'location', 'best')
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure2_Velocity_SliderCrankMechanism','-depsc')

%% Rest of the code is written by SURAJ JAISWAL

% Kinematic analysis on acceleration level

Ctt_fun = @(t, q, dq) g(revolute, simple, driving, t, q, dq);
[T, Q, QP, QPP] = pos_vel_acc_NR(C_fun, Cq_fun, Ct_fun, Ctt_fun, 1, q_0, 0.1);

figure(4)
plot(QPP(:, 4), QPP(:, 5), ...
    QPP(:, 7), QPP(:, 8), ...
    QPP(:, 10), QPP(:, 11), ...
    0, 0, '*', 'LineWidth', 2);
axis equal
grid on;
grid minor;
xlabel('Acceleration, ${{\ddot{q}}_x}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
ylabel('Acceleration, ${{\ddot{q}}_y}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
legend({'Crank','Connection rod','Slider','Origin'},'FontSize',12, 'FontName', 'Times New Roman', 'location', 'best')
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure3_Acceleration_SliderCrankMechanism','-depsc')


%% Slider crank dynamic analysis

inputData.grav = [0; -9.81]; % gravitational acceleration

body1.m = 0; % mass equals to one kg
body1.l = 0; 
body1.Ic = body1.m * body1.l^2 / 12; % mass moment of inertia along center of mass in kgm2
% body1.q = [1;2;3];

body2.m = 2; % mass equals to one kg
body2.l = 0.2; 
body2.Ic = body2.m * body2.l^2 / 12; % mass moment of inertia along center of mass in kgm2

body3.m = 2; % mass equals to one kg
body3.l = 0.5; 
body3.Ic = body3.m * body3.l^2 / 12; % mass moment of inertia along center of mass in kgm2

body4.m = 2; % mass equals to one kg
body4.l = 0; 
body4.Ic = body4.m * body4.l^2 / 12; % mass moment of inertia along center of mass in kgm2

inputData.body = [body1; body2; body3; body4];

inputData.tspan = 0:0.05:10;

C_DA_fun = @(t, q) constraint_DynamicAnalysis(revolute, simple, t, q);

inputData.C_q_fun = @(t, q) constraint_dq_DynamicAnalysis(revolute, simple, t, q); % Jacobian of our constraints

inputData.G_fun = @(t, q, dq) g_DynamicAnalysis(revolute, simple, t, q, dq);

h = 0.05; % time-step
alpha = 1/h;
beta = sqrt(2)/h;
inputData.G_Stab_fun = @(t, q, dq) inputData.G_fun(t,q,dq) - 2*alpha*inputData.C_q_fun(t,q)*dq - beta^2*C_DA_fun(t,q); % Applying Baumgarte Stabilization

q0 = [q_0; zeros(length(q_0), 1)];

options = odeset('Stats', 'on','RelTol',1e-6);
tic
% Using ode45 to solve for equations of motion
[t,y] = ode45(@Dynamic_Analysis_EOM, inputData.tspan, q0, options, inputData);
toc
Solun = y';

% Animation of Dynamic Analysis
figure(5)
for iii = 1:length(inputData.tspan)
    clf
%     axis equal
%     grid on
%     grid minor
    hold on
    
    r1_J1 = [Solun(4,iii);Solun(5,iii)] + [cos(Solun(6,iii)) -sin(Solun(6,iii)); sin(Solun(6,iii)) cos(Solun(6,iii))]*[inputData.body(2).l/2;0];
    r1_J2 = [Solun(4,iii);Solun(5,iii)] + [cos(Solun(6,iii)) -sin(Solun(6,iii)); sin(Solun(6,iii)) cos(Solun(6,iii))]*[-inputData.body(2).l/2;0];
    r2_J2 = [Solun(7,iii);Solun(8,iii)] + [cos(Solun(9,iii)) -sin(Solun(9,iii)); sin(Solun(9,iii)) cos(Solun(9,iii))]*[inputData.body(3).l*3/5;0];
    r2_J3 = [Solun(7,iii);Solun(8,iii)] + [cos(Solun(9,iii)) -sin(Solun(9,iii)); sin(Solun(9,iii)) cos(Solun(9,iii))]*[-inputData.body(3).l*2/5;0];
    r3_J3 = [Solun(10,iii);Solun(11,iii)] + [cos(Solun(12,iii)) -sin(Solun(12,iii)); sin(Solun(12,iii)) cos(Solun(12,iii))]*[0;0];

    plot([r1_J1(1), r1_J2(1)], [r1_J1(2), r1_J2(2)], 'LineWidth',2)
    plot([r2_J2(1), r2_J3(1)], [r2_J2(2), r2_J3(2)], 'LineWidth',2)
    plot(r3_J3(1), r3_J3(2),'*', 'LineWidth',4)
    plot(0,0, '*', 'LineWidth', 4)
    
    axis([- 0.75 0.25 -0.5 0.5])

    grid on;
    grid minor;
    xlabel('Position, ${q_x}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
    ylabel('Position, ${q_y}$ (m)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
    legend({'Crank','Connection rod','Slider','Origin'},'FontSize',12, 'FontName', 'Times New Roman', 'location', 'best')
    title('Dynamic Analysis of Slider Crank Mechanism','FontSize',12, 'FontName', 'Times New Roman')
    set(gca,'FontSize',12, 'FontName', 'Times New Roman');
    
    pause(0.05)
    drawnow
    
end