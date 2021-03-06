lambda = 0;
R_range = [0.4,0.55,0.7,0.85];        % choice of R
for i = 1:numel(R_range)
    R = R_range(i);     %setting value of R
    alpha = (1/4)*(1-4*R^3)+(3/4)*lambda*(1-3*R^2);
    beta = 1-R^3 + 3*lambda*(1-R^2);
% used to analytically calculate max pressure and the corresponding r
    if alpha > 0
        r_max=((beta/alpha)^(1/3))*R;
        p_max = 1 + R^(-3)*(alpha^4/beta)^(1/3);
    else
        p_max = 1;
        r_max = inf;
    end
    disp([i,r_max,p_max])
% plotting between r=0.5 and 3    
    r = linspace(R_range(i),10,10^6);        % r>R
    results = zeros(1,numel(r)+1);
    for j = 1:(numel(r))
        results(j) = 1 + 4*alpha/(3*r(j)*R^2) - beta*R/(3*r(j)^4);
    end
% below is done to avoid the situation where p_max is not 1 in the range of the plot
    results(numel(r)+1) = 1;        
% normalise the results s.t. p_max-p_min =1 
    normalised_results = normalize(results,'range');    
    plot(r,normalised_results(1:numel(r)), ...
        'DisplayName',['R=' num2str(R_range(i))])
    hold on 
end
set(gca,'YGrid',"on")
xlabel('r'),ylabel('p(r,R)')
hold off
legend


