% Created by:   Suraj Jaiswal
% Date:         29.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Slider Crank Mechanism

clc; clear; close all;

a = 0.1; % in meter
b = 0.2; % in meter
phi = 30*pi/180; % in radian
omega = 1; % in rad/s
syms theta d 

x = [theta;
     d];
f = [a*cos(phi) + b*cos(theta) - d;
     a*sin(phi) - b*sin(theta)];

% Solution for f(x)=0 for x for given phi
S = solve(f==0, x);
Sol1 = vpa(S.theta*180/pi) % soultion for theta in degree
Sol2 = vpa(S.d) % solution for d in meter

J = jacobian(f, x);

% matlabFunction(x, 'file', 'X');
% matlabFunction(f, 'file', 'F');
% matlabFunction(J, 'file', 'J');
