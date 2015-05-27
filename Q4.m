% Simplified version of the problem in Textbook HLS: page 201
function Q4_path
%Function to calculate the price of the Asian option on arithmetic
%average.
%Displays the price of the option
clc;

%Initial parameters
S0=40;     %USD
r=0.1;     %risk-free rate
sigma=0.3;  %volatility
k=42; %USD
T=1;        %Time to maturity (years)
H = 40;
T_H = 0.5;
%for number of steps in each path, choose a value that generates at least
%one price per day, but that takes a reasonable amount of time to run
number_of_steps=500;
DeltaT=T/number_of_steps;
%number of trajectories should be as big as possible while still running
%the function in a reasonable amount of time
power = 1:4;
N = 10.^power;

price = zeros(length(N),1);
price_SEM = zeros( length(N),1);

for i = 1:length(N)
    current_N=N(i);
    
    payoff = zeros(length(current_N));
    %We compute each path
    num_paths_per_function_call = 1;
    for trajectory_number=1:current_N
        %Generate a single simulated stock price path from time 0 to time T.
        %There will be number_of_steps + 1 prices in this path (the first price
        %is S0).
        Path=GenerePaths(S0,r,sigma,num_paths_per_function_call,...
            number_of_steps,DeltaT);
        
      
        if Path(floor(length(Path)*T_H/T)) < H;
            payoff(trajectory_number) = max(Path(end)-k,0);
        else
            payoff(trajectory_number) = 0;
        end
        
        discounted_payoff = payoff .* exp(-r*T);
    end
    
    %Calculation of the cash flows, the average and the standard deviation
    %The discounted payoff in each simulation depends on the average price
    %along the simulated path. Each simulated path (trajectory) is
    %INDEPENDENT, and the payoff for each simulation should only depend on ONE
    %path.
%     Payoff=exp(-r*T)*max(average_stock_prices-k,0);
%     
    price(i)=mean(discounted_payoff);
    price_SEM(i) = std(discounted_payoff)/ sqrt( current_N ); 
end


disp('             N         Price         std Error');
disp([N', price, price_SEM]);


% disp('std Error');
% disp(price_SEM);



function Rep=GenerePaths(S0,r,sigma,NbTraj,NbStep,DeltaT)
%Function to generate the paths.
%S0: Initial price of the asset
%r: Risk-free rate
%sigma: Volatility
%NbTraj: Number of simulated paths
%NbStep: Number of time steps per path
%DeltaT: Delta T for each step

NuT = (r - sigma*sigma/2)*DeltaT;
SqDelta = sqrt(DeltaT);
DeltaW = SqDelta*randn(NbTraj, NbStep);
Increments = NuT + sigma*DeltaW;
LogPaths = cumsum([log(S0)*ones(NbTraj,1) , Increments] , 2);
Rep = exp(LogPaths);
