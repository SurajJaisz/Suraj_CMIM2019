% Created by:   Suraj Jaiswal
% Date:         28.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     3.12: Revisit fit of sines to a function

clc; clear all;

M = 400;
t = linspace(-pi, pi, M);
f = @(t) t/pi;

Snt = sinesum(t, b, N)

% % 
% % syms X Y
% % F=sqrt(3).*(2.*(X.^2+Y.^2)-1);
% % diff(F,X)
% % diff(F,Y)
% % diff(F,X,Y)


N = 3;
b = [4, -3, 7];
% test_sinesum()

% trial(f, N, M, t);
% plot_compare(f, N, M, t)

[v1, b1_ref] = auto(f, M, t, N);