% Parameters
numRuns = 50; % number of times the GA will be run
optimalCongestions = zeros(numRuns, 1); % Array to store the optimal congestion from each run

% Run the GA multiple times
for i = 1:numRuns
    % Run the GA and get the optimal signal timings and congestion
    [optimalSignalTimings, optimalCongestion] = ga(objectiveFcn, numJunctions, [], [], [], [], lb, ub, [], gaOptions);
    
    % Store the optimal congestion
    optimalCongestions(i) = optimalCongestion;
end

% Calculate the average and standard deviation of the optimal congestion
averageOptimalCongestion = mean(optimalCongestions);
stdDevOptimalCongestion = std(optimalCongestions);

% Display the results
fprintf('\n');
fprintf('Performance Evaluation of the Genetic Algorithm\n');
fprintf('--------------------------------------------------------\n');
fprintf('Average optimal congestion over %d runs: %.2f\n', numRuns, averageOptimalCongestion);
fprintf('Standard deviation of optimal congestion over %d runs: %.2f\n', numRuns, stdDevOptimalCongestion);
fprintf('--------------------------------------------------------\n');
