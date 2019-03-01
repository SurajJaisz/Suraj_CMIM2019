function E = error(b_coefficient, f, M, t, N)

% err =@(k) (b_coefficient(1)*sin(1*k)+b_coefficient(2)*sin(2*k)+b_coefficient(3)*sin(3*k)-(k/pi))^2;

err =@(k) (sinesum(k, b_coefficient, N)-f(k))^2;

E = trapezoidal(err, t(1), t(end), M); % computed error using trapezoidal rule

end