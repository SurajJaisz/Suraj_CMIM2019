% Function to verify the implementation of integrate_coeffs
% Created by:   Suraj Jaiswal
% Date:         01.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

%% test_integrate_coeff
clc; clear; close all;
M = 100;
t = linspace(-pi, pi, M);
f = @(t) t/pi;
N = 15;
t_begin = t(1);
t_end = t(end);
tol = 1E-1;

b_coefficient = integrate_coeffs(f, N, M, t); % numerical evaluation of coeffcients
E = error(b_coefficient, f, M, t, N);

assert(E < tol, 'Test failed because for n=%d, the error is %g', M, E);
