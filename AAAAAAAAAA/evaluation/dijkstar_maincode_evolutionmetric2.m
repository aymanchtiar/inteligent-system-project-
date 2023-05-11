% Dijkstra Algorithm for Multimodal Transportation Systems with Travel Modes

% Create a random adjacency matrix representing the transportation network
num_nodes = 10;
travel_modes = {'walking', 'bus', 'metro', 'bicycle'};
mode_weights = [6, 2, 1, 4]; % Weights for the travel modes

% Number of iterations to average performance
num_iterations = 100;

% Initialize result table
result_table = table('Size', [num_iterations, 3],...
    'VariableTypes', {'double', 'cell', 'double'},...
    'VariableNames', {'Iteration', 'Path', 'ExecutionTime'});

for iter = 1:num_iterations
    % Generate new adjacency matrix and mode matrix
    adj_matrix = inf(num_nodes); % Initialize with infinite distances
    mode_matrix = cell(num_nodes);
    node_modes = cell(1, num_nodes);

    for i = 1:num_nodes
        node_modes{i} = travel_modes{randi([1, length(travel_modes)])};
    end

    for i = 1:num_nodes
        for j = i+1:num_nodes
            mode_idx = find(strcmp(travel_modes, node_modes{i}));
            adj_matrix(i, j) = randi([500, 1000]) * mode_weights(mode_idx); % Multiply distance by mode weight
            adj_matrix(j, i) = adj_matrix(i, j);
            mode_matrix{i, j} = node_modes{i};
            mode_matrix{j, i} = mode_matrix{i, j};
        end
    end

    % Apply the algorithm to the randomly generated transportation network
    start_node = 1;
    end_node = 10;
    while end_node == start_node
        end_node = randi([1, num_nodes]);
    end

    tic; % Start timer
    [min_distance, path, path_modes] = dijkstra(adj_matrix, mode_matrix, start_node, end_node);
    execution_time = toc; % Stop timer and get elapsed time

    % Save iteration results to the table
    result_table.Iteration(iter) = iter;
    result_table.Path{iter} = num2str(path);
    result_table.ExecutionTime(iter) = execution_time;
end

% Display the result table
disp(result_table)

% Print the average execution time
average_execution_time = mean(result_table.ExecutionTime);
fprintf('Average execution time: %.6f seconds\n', average_execution_time);
