 

function [min_distance, path, path_modes] = dijkstra(adj_matrix, mode_matrix, start_node, end_node) 

    num_nodes = length(adj_matrix); 

    unvisited_nodes = 1:num_nodes; 

    min_distance = inf(1, num_nodes); 

    min_distance(start_node) = 0; 

    prev_node = zeros(1, num_nodes); 

  

    while ~isempty(unvisited_nodes) 

        % Find the node with the smallest distance 

        [~, idx] = min(min_distance(unvisited_nodes)); 

        curr_node = unvisited_nodes(idx); 

  

        % If we have reached the end node, break the loop 

        if curr_node == end_node 

            break; 

        end 

  

        % Remove the current node from the unvisited_nodes list 

        unvisited_nodes(idx) = []; 

  

        % Update distances to the neighboring nodes 

        neighbors = find(adj_matrix(curr_node, :) < inf); 

        for neighbor = neighbors 

            alt_distance = min_distance(curr_node) + adj_matrix(curr_node, neighbor); 

            if alt_distance < min_distance(neighbor) 

                min_distance(neighbor) = alt_distance; 

                prev_node(neighbor) = curr_node; 

            end 

        end 

    end 

  

    % Reconstruct the shortest path and travel modes 

    path = []; 

    path_modes = cell(1, 0); 

    if prev_node(end_node) ~= 0 || start_node == end_node 

        curr_node = end_node; 

        while curr_node ~= 0 

            path = [curr_node, path]; 

            if curr_node ~= start_node 

                path_modes = [mode_matrix{prev_node(curr_node), curr_node}, path_modes]; 

            end 

            curr_node = prev_node(curr_node); 

        end 

    end 

end 