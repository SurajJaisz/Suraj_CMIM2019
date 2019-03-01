function b_total = integrate_coeffs(f, N, M, t)
% Function to compute coefficients by numerical integration
%               b denotes the array of coefficients
% Created by:   Suraj Jaiswal
% Date:         01.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

a = t(1);
b = t(end);
n = M; % Intervals in the trapezoidal rule
for k = 1:N
    f = @(t) f(t)*sin(k*t);
    b_coeff = (1/pi)*trapezoidal(f, a, b, n);
    b_total(1,k) = b_coeff;
end

end