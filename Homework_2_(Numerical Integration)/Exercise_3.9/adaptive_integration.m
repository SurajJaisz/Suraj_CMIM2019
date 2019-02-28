function [integral, N, ERR] = adaptive_integration(f, a, b, eps, method, n)
% Function to implement the idea of adaptive integration
%               f denotes the function
%               [a, b] denotes the integral limits
%               n denotes the number of integration points
%               eps denotes the tolerance
%               method can be midpoint or trapezoidal
%               n denotes the number of integration points
% Created by:   Suraj Jaiswal
% Date:         28.02.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

numerical_n = trapezoidal(f, a, b, n); % compute result for n
numerical_2n = trapezoidal(f, a, b, (2*n)); % compute result for 2n
error = abs(numerical_n - numerical_2n);
while error > eps
    n = 2*n;
    numerical_n = trapezoidal(f, a, b, n); % compute result for n
    numerical_2n = trapezoidal(f, a, b, (2*n)); % compute result for 2n
    error = abs(numerical_n - numerical_2n);
end

integral = numerical_2n;
N = 2*n;
ERR = error;

%%% ALTERNATE METHOD FOR WRITING THE FUNCTION, IF YOU DONT USE WHILE LOOP

% % if error < eps
% %     integral = numerical_2n;
% %     N = 2*n;
% %     ERR = error;
% % else
% %     [integral, N, ERR] = adaptive_integration(f, a, b, eps, method, 2*n);
% % end

end