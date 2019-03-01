% Created by:   Suraj Jaiswal
% Date:         27.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     3.6: Explore rounding errors with large numbers

%% test_trapezoidal2
% Check that linear functions are integrated exactly
f = @(x) 6*10^8*x - 4*10^6;
F = @(x) 3*10^8*x^2 - 4*10^6*x; % Anti-derivative
a = 1.2; b = 4.4;
exact = F(b) - F(a); % expected result
% tol = 1E-14; % Test fails with this tolerance
tol = 1E-6;
for n =  1:4
    numerical = trapezoidal(f, a, b, n); % computed result
    error = abs(exact - numerical);
    assert(error < tol, 'n=%d, err=%g', n, error);
end

%% test_trapezoidal_conv_rate
% Check empirical convergence rates
f = @(x) 6*10^8*x - 4*10^6;
F = @(x) 3*10^8*x^2 - 4*10^6*x; % Anti-derivative
a = 1.2; b = 4.4;
num_experiments = 14;
r = convergence_rates(f, F, a, b, num_experiments);
tol = 1E-14; % Test passed with this tolerance
% tol = 1E-6; % Test passed with this tolerance
% tol = 0.01; % Test passed with this tolerance
assert(abs(r(num_experiments-1)) - 2 < tol, '%f, %f, %f, %f, %f',... 
                r((num_experiments-1)-4:num_experiments-1));

