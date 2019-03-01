function plot_approx(f, NN, M, filename)
% Function to plots the original function f(t) together with the sum of sines SN(t), 
% so that the quality of the approximation SN(t) can be examined visually 

t=linspace(-pi,pi,M);     % array of all values of t for which the functions are to be plotted

plot(t,f(t),'LineWidth',2)
hold on
    
for ii=1:length(NN)
    b = integrate_coeffs(f, NN(ii), M, t); % numerical evaluation of coeffcients
    Snt = sinesum(t, b, NN(ii));
    plot(t,Snt,'LineWidth',1)
    ylabel ('Values for function f(t) and Sn(t)','FontSize',12, 'FontName', 'Times New Roman');
    xlabel ('Values of t','FontSize',12, 'FontName', 'Times New Roman');
    Legend{1} = 'f(t)';
    Legend{ii+1} = ['Sn(t) for N = ', num2str(NN(ii))];
    set(gca,'FontSize',12, 'FontName', 'Times New Roman');
    grid on
    hold on
end
legend(Legend, 'Location', 'best')
print(filename,'-depsc')

end