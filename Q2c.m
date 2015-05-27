%STU: 15/15 points. 
clear;
clc;
format bank;

%portfolio 
holding_bear = 20;  % options to buy "holding_put" shares of stocks
holding_stock = 25;  % shares of stocks

% VaR parameters
X = 0.99;
trading_days_per_year = 250;
horizon_days = 20;
%since our mu and volatility are annualized, we want our horizon 
%time in years
horizon_years = horizon_days/trading_days_per_year; % year


% Underlying Asset parameters
s0 = 42;
vol = 0.2;
mu = 0.05;

%option parameters
expiry = 0.5;
k_long = 40;
k_short = 35;
%market parameter
r = 0.1;

% computation parameters
N_path_VaR = 10000;
N_path_option = 1000;


% stock price at N
sN = s0*exp( (mu-vol*vol/2)*horizon_years + vol*sqrt(horizon_years)*randn(N_path_VaR,1) );

% European call price at N
put_price_N = zeros(N_path_VaR,1);
for k = 1:N_path_VaR
    put_price_N(k) = get_eu_put_price_mc( ...
        sN(k), k_long, k_short, r, vol, expiry - horizon_years, N_path_option);
end

% portfolio values (puts + stock)
portfolioValue = holding_bear * put_price_N + holding_stock * sN;
portfolioValue = sort(portfolioValue);

portfolioValue_average = mean(portfolioValue);
VaR_pos = floor( length(portfolioValue) * (1-X) );

VaR = portfolioValue_average - portfolioValue( VaR_pos );

disp('the average of the portfolio in 20 days');
disp(portfolioValue_average);
disp('  ');
disp('20-day 99% VaR');
disp(VaR);


% disp(mean(put_price_N))



