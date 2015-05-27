function payoff = get_barrier_payoff( sT, sT_H, k, H )


% if sT_H < H
%     payoff = max (sT - k,0);
% else
%     payoff = 0;
% end

payoff = ((sT_H - H) < 0).*max((sT - k),0);
% discountedPayoff = payoff * exp(-r*T);
% 
% 
% gap_price = mean(discountedPayoff);

% payoff = max(s - k,0);

