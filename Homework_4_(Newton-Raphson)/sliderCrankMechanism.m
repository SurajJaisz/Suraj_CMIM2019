% Created by:   Suraj Jaiswal
% Date:         29.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Slider Crank Mechanism

clc; clear; close all;

a = 0.1; % in meter
b = 0.2; % in meter
% phi = 30*pi/180; % in radian
omega = 1; % in rad/s

t = 0:0.01:10; % time
tol = 1e-6; % Parameter (tolerance) for Newton-Raphson scheme
maxiter = 1000; % Parameter (maximum iteration) for Newton-Raphson scheme

f =@(x,phi) [a*cos(phi) + b*cos(x(1)) - x(2); a*sin(phi) - b*sin(x(1))]; % function f

J =@(x) [-b*sin(x(1)), -1; -b*cos(x(1)), 0]; % Jacobian of f w.r.t x

dfdt = @(phi) [-a*sin(phi)*omega; a*cos(phi)*omega]; % Time derivative of function f

G = @(x,x_dot,Phi) [a*cos(Phi)*omega^2 + b*cos(x(1))*x_dot(1)^2; ...
                        a*sin(Phi)*omega^2 - b*sin(x(1))*x_dot(1)^2]; % Double time derivative of function f

% % Solution for f(x)=0 for x for given phi
% S = solve(f==0, x);
% Sol1 = double(vpa(S.theta*180/pi)); % soultion for theta in degree
% Sol2 = double(vpa(S.d)); % solution for d in meter
% fprintf('Theta: %.2f\n',Sol1)
% fprintf('d: %.2f\n',Sol2)

for i = 1:length(t)
    
    phi = omega*t(i) + pi/6;
    xini = [asin(1/4); 0.28]; % initial values assumed
     
    [x, iteration_counter] = NR_method(f, J, xini, tol, maxiter, phi);
    
    x_dot  = J(x)\-dfdt(phi); % computing velocity
    x_2dot = J(x)\G(x,x_dot,phi); % computing acceleration 
    
    x_save(:,i) = x; % computing position    
    x_dot_save(:,i)  = x_dot; % computing velocity
    x_2dot_save(:,i) = x_2dot; % computing acceleration 

end

% Position plot
figure(1);
yyaxis left
plot(t, x_save(1,:)*180/pi,'-','LineWidth',1);
grid on;
grid minor;
xlabel('time (s)','FontSize',12, 'FontName', 'Times New Roman');
ylabel('Angle, \theta ({\circ})','FontSize',12, 'FontName', 'Times New Roman');
hold on;
yyaxis right
plot(t, x_save(2,:),'--','LineWidth',1);
ylabel('Displacement, d (m)','FontSize',12, 'FontName', 'Times New Roman');
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure1_Position','-depsc')

% Velocity plot
figure(2);
yyaxis left
plot(t, x_dot_save(1,:),'-','LineWidth',1);
grid on;
grid minor;
xlabel('time (s)','FontSize',12, 'FontName', 'Times New Roman');
ylabel('Angular velocity, $\dot{\theta}$ (rad/s)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
hold on;
yyaxis right
plot(t, x_dot_save(2,:),'--','LineWidth',1);
ylabel('Velocity, $\dot{d}$ (m/s)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure2_Velocity','-depsc')

% Acceleration plot
figure(3);
yyaxis left
plot(t, x_2dot_save(1,:),'-','LineWidth',1);
grid on;
grid minor;
xlabel('time (s)','FontSize',12, 'FontName', 'Times New Roman');
ylabel('Angular acceleration $\ddot{\theta}$ (rad/s$^2$)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
hold on;
yyaxis right
plot(t, x_2dot_save(2,:),'--','LineWidth',1);
ylabel('Acceleration, $\ddot{d}$ (m/s$^2$)','FontSize',12, 'FontName', 'Times New Roman','interpreter','latex');
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
print('Figure3_Acceleration','-depsc')

