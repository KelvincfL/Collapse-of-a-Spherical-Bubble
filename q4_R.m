format long
lambda = [0.01,0.1,0.5,1,10,100];
for k = 1:numel(lambda)
    if lambda(k) > 1        % for better accuracy with large lambda
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
% plotting R against t
    figure(1)
    plot(t_range,R(1:i-1),"DisplayName",['\lambda=', num2str(lambda(k))])
    hold on
    xlabel('t'),ylabel('R')
    
    clear X i h n
end
hold off
legend