% Created by:   Suraj Jaiswal
% Date:         27.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Exercise 3.6: Explore rounding errors with large numbers

%% test_trapezoidal2
% Check that linear functions are integrated exactly
f = @(x) 6*10^8*x - 4*10^6;
F = @(x) 3*10^8*x^2 - 4*10^6*x; % Anti-derivative
a = 1.2; b = 4.4;
exact = F(b) - F(a); % expected result
tol = 1E-14;
for n =  1:4
    numerical = trapezoidal(f, a, b, n); % computed result
    error = abs(exact - numerical);
    assert(error < tol, 'n=%d, err=%g', n, error);
end




