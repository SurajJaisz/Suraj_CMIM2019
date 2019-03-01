function r = convergence_rates(f, F, a, b, num_experiments)
  n = zeros(num_experiments, 1);
  E = zeros(num_experiments, 1);
  r = zeros(num_experiments-1, 1);
  exact = F(b) - F(a);

  for i = 1:num_experiments
    n(i) = 2^i;
    numerical = trapezoidal(f, a, b, n(i));
    err = abs(exact - numerical);
    E(i) = err;
    if (i > 1)
      r(i-1) = log(E(i-1)/E(i))/log(n(i-1)/n(i));
      r(i-1) = round(r(i-1)*100)/100;  % Truncate, two decimals
   end
  end
end