%STU: 10/10 points. 
clc; clear;

s = 20:60;
k_short = 35;
k_long = 40;

payoff = Q2a(s , k_long , k_short);


disp('The payoff of Bear spread')
disp(payoff')

plot(s,payoff)