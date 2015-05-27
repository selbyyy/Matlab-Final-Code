function payoff = get_put_payoff( s, k )
%compute the payoff of call options
%   s - spot price(s)
%   k - strike price(s)

payoff = max(k - s ,0);

