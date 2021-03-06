format long
h = 10^(-7);
n = 1/h;
lambda = 0;
f = @(x,t) (-5/2)*sqrt((2/3)*(1-x^(6/5)));    % formula for dx/dt, lambda=0

X(1) = 1;     % val x(0)
X(2) = 1 - (5/4)*h^2;   % val x(h)

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
plot(t_range,R(1:i-1))
xlim([0,t_c+0.05]),ylim([0,1]),xlabel('t'),ylabel('R')
% finding p_max(t)
for j = 1:i-1
    alpha = (1/4)*(1-4*R(j)^3)+(3/4)*lambda*(1-3*R(j)^2);
    beta = 1-R(j)^3 + 3*lambda*(1-R(j)^2);
    if alpha > 0
        p_max(j) = 1 + R(j)^(-3)*(alpha^4/beta)^(1/3);
    else
        p_max(j) = 1;
    end
end
% plotting p_max against t
figure(2)
plot(t_range,p_max)
set(gca, 'YScale', 'log')
xlim([0,t_c+0.05]),xlabel('t'),ylabel('p_{max}')

