% Simplified version of the problem in Textbook HLS: page 201 
function ArithOptCall
 %Function to calculate the price of the Asian option on arithmetic
 %average.
 %Displays the price of the option
 clc;

 %Initial parameters
 S0=100;     %USD
 r=0.03;     %risk-free rate
 sigma=0.3;  %volatility
 Strike=100; %USD
 T=1;        %Time to maturity (years)
 
 %for number of steps in each path, choose a value that generates at least
 %one price per day, but that takes a reasonable amount of time to run
 number_of_steps=250;
 DeltaT=T/number_of_steps;
 %number of trajectories should be as big as possible while still running
 %the function in a reasonable amount of time
 number_of_trajectories=30000;

 %Vector used to keep the values needed to calculate the payoffs
 average_stock_prices=zeros(number_of_trajectories,1);

 %We compute each path
 num_paths_per_function_call = 1;
 for trajectory_number=1:number_of_trajectories
    %Generate a single simulated stock price path from time 0 to time T.
    %There will be number_of_steps + 1 prices in this path (the first price
    %is S0).
    Path=GenerePaths(S0,r,sigma,num_paths_per_function_call,...
                                                   number_of_steps,DeltaT);

    %Calculation of the arithmetic average
    average_stock_prices(trajectory_number)=mean(Path);
 end

 %Calculation of the cash flows, the average and the standard deviation
 %The discounted payoff in each simulation depends on the average price
 %along the simulated path. Each simulated path (trajectory) is
 %INDEPENDENT, and the payoff for each simulation should only depend on ONE
 %path.
 Payoff=exp(-r*T)*max(average_stock_prices-Strike,0);
 
 option_price=mean(Payoff,1);
 disp('Option Price');
 disp(option_price);
 
 disp('std Error');
 disp(std(Payoff)/sqrt(number_of_trajectories));
 


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
