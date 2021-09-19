lambda = [0.0,0.01,0.1,1.0];     
R = logspace(-5,0,10000);       % log distributed points of R for plotting
dR_dt = zeros(1,numel(R));
% for loop used to plot the individual curves
for i = 1:numel(lambda)
    for j = 1:numel(R)
        dR_dt(j) = -sqrt(2/3*((1/R(j)^3)-1) +2*lambda(i)*(1/R(j)^3-1/R(j)));
    end
    plots(i) = loglog(R,dR_dt,"DisplayName",['\lambda=' num2str(lambda(i))]);
    hold on
end
hold off
legend(plots)
xlabel('R'), ylabel('dR/dt')