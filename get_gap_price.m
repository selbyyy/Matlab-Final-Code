function gap_price = get_gap_price( s0, k1, k2, r, vol, T, N)


sT = s0*exp( (r-vol*vol/2)*T + vol*sqrt(T)*randn(N,1) );

% for i = 1:N
%     
%     if sT(i) > k2
%         payoff(i) = sT(i) - k1;
%     else
%         payoff(i) = 0;
%     end
%     
%     
%     discountedPayoff(i) = payoff(i) * exp(-r*T);
% end


payoff = ((sT - k2) > 0).*(sT - k1);
discountedPayoff = payoff * exp(-r*T);


gap_price = mean(discountedPayoff);







