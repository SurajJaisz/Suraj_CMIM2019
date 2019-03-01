
% Function to verify the implementation of integrate_coeffs
%               b denotes the array of coefficients
% Created by:   Suraj Jaiswal
% Date:         01.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

%% test_integrate_coeff
M = 400;
t = linspace(-pi, pi, M);
f = @(t) t/pi;
F = @(t) t^2/(2*pi);
N = 5; % Lets assume that it is one for the sake of simplicity
t_begin = t(1);
t_end = t(end);
tol = 1E-14;

exact = F(t_end) - F(t_begin); % expected result
b_numerical = integrate_coeffs(f, N, M, t); % numerical evaluation of coeffcients
Snt_numerical = sinesum(t, b_numerical, N); % computed result

error = abs(exact - Snt_numerical);
assert(error < tol, 'Test failed because for n=%d, the error is %g', M, error);
