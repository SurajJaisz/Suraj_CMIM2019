function plot_approx(f, N, M, filename)
% Function to plots the original function f(t) together with the sum of sines SN(t), 
% so that the quality of the approximation SN(t) can be examined visually 

t=linspace(-pi,pi,M);     % array of all values of t for which the functions are to be plotted

b = integrate_coeffs(f, N, M, t); % numerical evaluation of coeffcients
Snt = sinesum(t, b, N);

figure(N)
plot(t,f(t),t,Snt,'LineWidth',2)
hold on
ylabel ('Values for function f(t) and Sn(t)','FontSize',12, 'FontName', 'Times New Roman');
xlabel ('Values of t','FontSize',12, 'FontName', 'Times New Roman');
legend('f(t)','Sn(t)')
% title('Comparison between f(t) and SN(t)');
set(gca,'FontSize',12, 'FontName', 'Times New Roman');
grid on
hold off

print(filename,'-depsc')

end