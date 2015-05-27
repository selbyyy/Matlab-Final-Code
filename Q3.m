%STU: 20/20 points. 
clear;
clc;

%portfolio
holding = 50;  % options to buy "holding" shares of stocks

% VaR parameters
X = 0.99;
trading_days_per_year = 250;
horizon_days = 30;
%since our mu and volatility are annualized, we want our horizon
%time in years
horizon_years = horizon_days/trading_days_per_year; % year


% Underlying Asset parameters
s0 = 40;
vol = 0.2;
mu = 0.05;

%option parameters
expiry = 0.5;
K1 = 42;
K2 = 45;
%market parameter
r = 0.1;


power = 2:4;
N = 10.^power;

VaR = zeros(length(N),1);

for i = 1:length(N)
    % computation parameters
    Current_N = N(i);
    N_path_option = 1000;
    
    
    % stock price at N
    sN = s0*exp( (mu-vol*vol/2)*horizon_years + vol*sqrt(horizon_years)*randn(Current_N,1) );
    
    % European call price at N
    gappriceN = zeros(Current_N,1);
    for k = 1:Current_N
        gappriceN(k) = get_gap_price( ...
            sN(k), K1, K2, r, vol, expiry - horizon_years, N_path_option);
        
    end
    
    % disp(max(gappriceN))
    % This is to check did I got nonzero value in gap price 
    
    % portfolio values
    portfolioValue = holding * gappriceN;
    portfolioValue = sort(portfolioValue);
    
    portfoliValue_average = mean(portfolioValue);
    VaR_pos = floor( length(portfolioValue) * (1-X) );
    
    VaR(i) = portfoliValue_average - portfolioValue( VaR_pos );
    
end
disp('the average of the portfolio in 30 days');
disp(portfoliValue_average);
disp('  ');
disp('        N             30-day 99% VaR');
disp([N',VaR]);



