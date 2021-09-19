% numerical integration using trapezium rule
format long
f = @(x) (2/sqrt(6)).*(sin(x).^(2/3));
a = 0;
b = pi/2;
n = 10^8;       % number of intervals
h = (b-a)/n;
sum_temp = f(a)+f(b);
for i = 1:n
    sum_temp = sum_temp + 2*f(a+h*i);
end
I = (h/2)* sum_temp;
disp(I)