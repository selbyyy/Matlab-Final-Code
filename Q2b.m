% QFA
% Topic 3: Monte Carlo & Options Pricing
% updated on 04/02/2015
%STU: 10/10 points. 

clc; clear;

% parameters form John Hull, 7th ED, p294
s0 = 42;  % stock price at time zero
k_long = 40;   % Strike price
k_short = 35;
r = 0.1;  % risk free interest rate, per annum
vol = 0.2; % volatility
T = 0.5;  % maturity in years

drift = (r-vol*vol/2)*T;
diffusion = vol*sqrt(T);

power = 1:6;
N = 10.^power;

price = zeros(length(N),1);
price_SEM = zeros( length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) );      
    payoff = Q2a(sT, k_long , k_short);
    discounted_payoff = payoff * exp(-r*T);
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price(i) = mean(discounted_payoff);
    price_SEM(i) = std(discounted_payoff)/ sqrt( current_N ); 
    
end

format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, price_SEM]);





