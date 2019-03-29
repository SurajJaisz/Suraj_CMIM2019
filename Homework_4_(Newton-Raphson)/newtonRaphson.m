function x = newtonRaphson(f,dfdx,x0,tol,maxiter)
% Created by:   Suraj Jaiswal
% Date:         29.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     Slider Crank Mechanism

x = x0;
i = 0;

while any(abs(f(x)) > tol)
    x = x - dfdx(x)\f(x);
    i = i+1;
    if i >= maxiter
        disp('Newton-Raphson reached maximum number of iterations, tolerance not met!');
        return
    end
end