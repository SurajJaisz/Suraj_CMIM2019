% Created by:   Suraj Jaiswal
% Date:         28.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     3.9: Adaptive integration

clc; clear all;

% f = @(x) 6*x - 4;
f1 = @(x) x^2;
f2 = @(x) sqrt(x);

% a = 1.2; b = 4.4;
a = 0; b = 2;

% tol = 1E-14;
eps1 = 1E-01;
eps2 = 1E-10;

tol = eps2;
method = [];
n = 1;

% [integral_1, interval_1, error_1] = adaptive_integration(f1, a, b, tol, method, n)
[integral_2, interval_2, error_2] = adaptive_integration(f2, a, b, tol, method, n);

tolerance = linspace(eps1,eps2);

for i = 1:100
    [integral_3(1,i), interval_3(1,i), error_3(1,i)] = adaptive_integration(f2, a, b, tolerance(1,i), method, n);
end

figure()
plot(tolerance, interval_3, 'k-', 'LineWidth',2);
xlabel('Tolerance', 'FontSize',12, 'FontName', 'Times New Roman')
ylabel('Step, N', 'FontSize',12, 'FontName', 'Times New Roman')
set(gca, 'XScale', 'log')
%     set(gca,'FontSize',12, 'FontName', 'Times New Roman', 'XScale', 'log')
grid on
hold on


