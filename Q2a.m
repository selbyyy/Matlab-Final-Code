function payoff = Q2a(s, k_long, k_short)


%Vectorized
put_payoff1 = get_put_payoff(s , k_long);
put_payoff2 = get_put_payoff(s , k_short);

payoff = put_payoff1 - put_payoff2;