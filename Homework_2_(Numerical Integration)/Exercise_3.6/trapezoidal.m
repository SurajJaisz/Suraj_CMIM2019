function integral = trapezoidal(f, a, b, n)
% Function to compute approximation of integrals using composite trapezoidal method
%               f denotes the function
%               [a, b] denotes the integral limits
%               n denotes the number of integration points
% Created by:   Suraj Jaiswal
% Date:         27.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

h = (b-a)/n;
result = 0.5*f(a) + 0.5*f(b);
for i = 1:(n-1)
result = result + f(a + i*h);
end
integral = h*result;
end