function costs = calculate_fitness(particles, mountains, other_paths, num_segments, safe_distance)
    swarm_size = size(particles);
    for i = 1 : swarm_size(1)
        costs(i) = path_length_cost(cell2mat(particles(i)));
        costs(i) = costs(i) + mountain_terrain_cost(cell2mat(particles(i)), mountains, num_segments);
        costs(i) = costs(i) + collision_cost(cell2mat(particles(i)), other_paths, num_segments, safe_distance);
    end
end

