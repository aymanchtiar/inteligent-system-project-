% Dijkstra Algorithm for Multimodal Transportation Systems with Travel Modes  

% Create a random adjacency matrix representing the transportation network  

num_nodes = 10;  

adj_matrix = inf(num_nodes); % Initialize with infinite distances  

travel_modes = {'walking', 'bus', 'metro', 'bicycle'};  

mode_weights = [6, 2, 1, 4]; % Weights for the travel modes  

mode_matrix = cell(num_nodes);  

% Assign each node a mode of transportation  

node_modes = cell(1, num_nodes);  

for i = 1:num_nodes  

node_modes{i} = travel_modes{randi([1, length(travel_modes)])};  

end  

% Connect all nodes directly with their associated mode of transportation  

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

start_node = randi([1, num_nodes]);  

end_node = randi([1, num_nodes]);  

while end_node == start_node  

end_node = randi([1, num_nodes]);  

end  

[min_distance, path, path_modes] = dijkstra(adj_matrix, mode_matrix, start_node, end_node);  

fprintf('Shortest path from the starting point %d to the destination %d: %s\n', start_node, end_node, num2str(path));  

fprintf('Travel modes: %s\n', strjoin(path_modes, ' -> '));  

fprintf('Minimum distance: %d meters (weighted)\n', min_distance(end_node));  

% Calculate the distances taken by each mode of transportation  

mode_distances = containers.Map(travel_modes, zeros(1, length(travel_modes)));  

for i = 1:length(path_modes)  

mode = path_modes{i};  

distance = adj_matrix(path(i), path(i + 1)) / mode_weights(find(strcmp(travel_modes, mode)));  

mode_distances(mode) = mode_distances(mode) + distance;  

end  

% Display the distances taken by each mode of transportation  

for mode = travel_modes  

distance_m = mod(mode_distances(mode{1}), 2000);  

fprintf('%s:  %.0f m\n', mode{1}, distance_m * mode_weights(find(strcmp(travel_modes, mode))));  

end 