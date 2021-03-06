format long

lambda = [0.01,0.1,0.5,1,10,100];

for k = 1:numel(lambda)
    if lambda(k) > 1
        h = 10^(-8);
        n = 1/h;
    else
        h = 10^(-7);
        n = 1/h;
    end
    f = @(x,t) (-5/2)*sqrt((2/3)*(1-x^(6/5))+2*lambda(k)*(1-x^(4/5)));    % formula for dx/dt, lambda=0
    X(1) = 1;     % val x(0)
    X(2) = 1 - (5/4)*h*(1+2*lambda(k))^2;   % val x(h)
    
    i = 2;      % corresponding to x((i-1)*h)
    while X(i) > 0
        X(i+1) = X(i) + h * f(X(i),i*h);        % forward euler
        i = i+1;
    end
    t_c = (i-1/2)*h;    % t average between 1st neg. and last pos. val of x
    disp(t_c)
    
    t_range = 0:h:(i-2)*h;
    R = X.^(2/5);
    % finding p_max(t)
    for j = 1:i-1
        alpha = (1/4)*(1-4*R(j)^3)+(3/4)*lambda(k)*(1-3*R(j)^2);
        beta = 1-R(j)^3 + 3*lambda(k)*(1-R(j)^2);
        if alpha > 0
            p_max(j) = 1 + R(j)^(-3)*(alpha^4/beta)^(1/3);
        else
            p_max(j) = 1;
        end
    end
% plotting p_max against t
    plot(t_range,p_max,"DisplayName",['\lambda=', num2str(lambda(k))])
    set(gca, 'YScale', 'log')
    xlim([0,0.95]),xlabel('t'),ylabel('p_{max}'),ylim([10^(-1),10^9])
    hold on
    clear X i h n p_max
end
hold off