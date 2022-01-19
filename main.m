run("params.m");

particles = cell(swarm_size, num_drones);

for i=1:num_drones
    particles(:,i) = logistic_map(initial_pos_drones(:,i), goal_pos_drones(:,i), swarm_size, dimension, mu, xmax, ymax, zmax);
end

for j=1:num_drones
    for i=1:swarm_size
        cost(i,j) = mountain_terrain_cost(cell2mat(particles(i,j)), mountains, num_segments);
        cost(i,j) = cost(i,j) + path_length_cost(cell2mat(particles(i,j)));
    end
    pbest_cost(:,j) = cost(:,j);
    pbest_path(:,j) = particles(:,j);
    [min_cost, min_index] = min(cost(:,j)); 
    gbest_cost(j) = min_cost;
    gbest_path(j) = particles(min_index, j);
end

velocities = cell(size(particles));
velocities(:,:) = mat2cell(zeros(3,41),3 ,41);

for i=1:num_drones
    for j = 1:max_iter
        w = wmax - (wmax-wmin)*j/max_iter;
        c1 = cmax - (cmax - cmin)*j/max_iter;
        c2 = cmin - (cmax - cmin)*j/max_iter;
        vmax = V1 - (V1 - V2)*j/max_iter;
        [particles(:,i), velocities(:,i)] = generate_new_particles(particles(:,i), velocities(:,i), pbest_path(:,i), gbest_path(i),w, c1, c2, vmax);
        cost(:,i) = calculate_fitness(particles(:,i), mountains, gbest_path(1:i-1), num_segments, d_safe);
    end
end