% Created by:   Suraj Jaiswal
% Date:         28.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     3.12: Revisit fit of sines to a function

clc; clear; close all;
M = 100;
t = linspace(-pi, pi, M);
f = @(t) t/pi;
N =3;
filename = 'Comparison between f(t) and SN(t)';


% Question (d)
% test_integrate_coeff

% Question (e)
b_qsn_e = integrate_coeffs(f, N, 100, t)

% Question (f)
figure(1)
plot_approx(f, N, M, filename);

% Question (g)
N1 = [3, 6, 12, 24];
figure(2)
plot_approx(f, N1, M, 'Comparison between f(t) and SN(t) for different N');

% Question (h)
f1 =@(t) exp^(-(t-pi));
% plot_approx(f1, 100, M, 'Comparison between f(t) and SN(t) for N=100');


