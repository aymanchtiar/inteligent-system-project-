
% MATLAB code for optimizing traffic signal timing using genetic algorithms 
% Define parameters 
numJunctions = 12; % Number of junctions 

minGreenTime = 10; % Minimum green light duration in seconds 

maxGreenTime = 60; % Maximum green light duration in seconds 

populationSize = 50; % Size of the population for the genetic algorithm 

maxGenerations = 100; % Maximum number of generations for the genetic algorithm 

% Objective function: This function should simulate the traffic network and 

% return a measure of congestion (e.g., total delay or average travel time) 

% based on the input traffic signal timings. 

objectiveFcn = @(signalTimings) trafficSimulation(signalTimings); 

  

% Define constraints: Lower and upper bounds for green light durations 

lb = minGreenTime * ones(1, numJunctions); 

ub = maxGreenTime * ones(1, numJunctions); 

  

% Set genetic algorithm options 

gaOptions = optimoptions('ga', ... 
'PopulationSize', populationSize, ... 
'MaxGenerations', maxGenerations, ... 
'Display', 'iter'); 

  

% Run the genetic algorithm 

[optimalSignalTimings, optimalCongestion] = ga(objectiveFcn, numJunctions, [], [], [], [], lb, ub, [], gaOptions); 

% Display the optimized signal timings and the resulting congestion 

fprintf('\n'); 

fprintf('Optimized Traffic Signal Timings and Resulting Congestion\n'); 

fprintf('--------------------------------------------------------\n'); 

for i = 1:numJunctions 

    fprintf('Junction %2d: Green light duration = %4.2f seconds\n', i, optimalSignalTimings(i)); 

end 

fprintf('\n'); 

fprintf('Optimal congestion (lower is better): %4.2f\n', optimalCongestion); 

fprintf('--------------------------------------------------------\n'); 

% The trafficSimulation function should be defined to simulate the traffic 

% network and return a measure of congestion. In this example, we use a 

% simple placeholder function, but in practice, a more sophisticated model 

% should be employed. 

function congestion = trafficSimulation(signalTimings) 

    % Placeholder function: Replace with a proper traffic simulation model 

    congestion = sum(signalTimings) * rand(1); % Simplified representation of congestion 

end 