% Created by:   Suraj Jaiswal
% Date:         29.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Slider Crank Mechanism

clc; clear; close all;

% a = 0.1; % in meter
% b = 0.2; % in meter
% phi = 30; % in degree
% omega = 1; % in rad/s

syms a b phi omega
syms theta d

x = [theta;
     d];
 
f = [a*cos(phi) + b*cos(theta) - d;
     a*sin(phi) - b*sin(theta)];
 
J = jacobian(f, x)
 
S = solve(f==0, x);