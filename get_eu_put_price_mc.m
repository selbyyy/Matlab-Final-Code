function putPrice = get_eu_put_price_mc( s0, k_long, k_short, r, vol, T, N)

% parameters form John Hull, p294

sT = s0*exp( (r-vol*vol/2)*T + vol*sqrt(T)*randn(N,1) );      
putPayoff = Q2a(sT,k_long, k_short);
discountedPayoff = putPayoff * exp(-r*T);
    
putPrice = mean(discountedPayoff);
% priceSEM = std(discountedPayoff)/ sqrt( N ); 






