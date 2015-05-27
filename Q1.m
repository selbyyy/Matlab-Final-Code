% QFA
% Topic 3: Monte Carlo & Options Pricing
% updated on 04/02/2015
%STU: final exam total: 91/100 points. 
%This problem: 19/25 points. 

clc; clear;

% parameters form John Hull, 7th ED, p294
s0 = 42;  % stock price at time zero
k = 40;   % Strike price
r = 0.1;  % risk free interest rate, per annum
vol = 0.2; % volatility
T2 = 0.5;  % maturity in years
T1 = 0.25;


drift = (r-vol*vol/2)*(T2-T1);
diffusion = vol*sqrt(T2-T1);

power = 1:4;
N = 10.^power;

price = zeros(length(N),1);
price_SEM = zeros( length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) );  
    %STU: Need an inner Monte Carlo simulation to price the call and the
    %put, not just get the payoff. -6 points. 
    call_payoff = get_call_payoff(sT,k);
    put_payoff = get_put_payoff(sT,k);
    payoff = max(call_payoff, put_payoff);
    discounted_payoff = payoff * exp(-r*T1);
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price(i) = mean(discounted_payoff);
    price_SEM(i) = std(discounted_payoff)/ sqrt( current_N ); 
    
end

format bank;
disp('      Nr of Paths       price         SEM');
disp([N', price, price_SEM]);





