% Dijkstra Algorithm for Multimodal Transportation Systems with Travel Modes  

% Create a random adjacency matrix representing the transportation network  
num_nodes = 10;  
travel_modes = {'walking', 'bus', 'metro', 'bicycle'};  
mode_weights = [6, 2, 1, 4]; % Weights for the travel modes  

% Initialize the counter for consistent results
consistent_results = 0;

% Number of iterations to test consistency
num_iterations = 100;

% Choose fixed start and end nodes
start_node = 1;  
end_node = 10;  
while end_node == start_node  
    end_node = randi([1, num_nodes]);  
end

% Store the first result to compare with the others
first_result_path = [];

% Initialize arrays to store the results for each run
paths = cell(num_iterations, 1);
path_modes_list = cell(num_iterations, 1);
min_distances = zeros(num_iterations, 1);

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
    [min_distance, path, path_modes] = dijkstra(adj_matrix, mode_matrix, start_node, end_node);  

    % Store the results for this run
    paths{iter} = num2str(path);
    path_modes_list{iter} = strjoin(path_modes, ' -> ');
    min_distances(iter) = min_distance(end_node);

    % If this is the first iteration, save the result
    if iter == 1
        first_result_path = path;
    else
        % Compare the current path with the first path
        if isequal(path, first_result_path)
            consistent_results = consistent_results + 1;
        end
    end
end

% Convert the results to a table and display the table
results = table(paths, path_modes_list, min_distances, 'VariableNames', {'Path', 'Travel Modes', 'Minimum Distance (weighted)'});
disp(results);

% Print the consistency rate
fprintf('Consistency rate: %.2f%%\n', (consistent_results / (num_iterations - 1)) * 100);
