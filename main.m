run("params.m");

%% Initialize swarm

particles = cell(swarm_size, num_drones);

for i=1:num_drones
    particles(:,i) = logistic_map(initial_pos_drones(:,i), goal_pos_drones(:,i), swarm_size, dimension, mu, xmax, ymax, zmax);
end

for j=1:num_drones
    for i=1:swarm_size
        cost(i,j) = mountain_terrain_cost(cell2mat(particles(i,j)), mountains, num_segments);
        cost(i,j) = cost(i,j) + path_length_cost(cell2mat(particles(i,j)));
        cost(i,j) = cost(i,j) + radar_threat_cost(cell2mat(particles(i,j)), radars(1), radars(2), radars(3), radars(4), num_segments, delta);
    end
    pbest_cost(:,j) = cost(:,j);
    pbest_path(:,j) = particles(:,j);
    [min_cost, min_index] = min(cost(:,j)); 
    gbest_cost(j) = 999;
    gbest_path(j) = particles(min_index, j);
end

velocities = cell(size(particles));
velocities(:,:) = mat2cell(zeros(3,41),3 ,41);

%% Main Loop

for i=1:num_drones
    for j = 1:max_iter
        w = wmax - (wmax-wmin)*j/max_iter;
        c1 = cmax - (cmax - cmin)*j/max_iter;
        c2 = cmin - (cmax - cmin)*j/max_iter;
        vmax = V1 - (V1 - V2)*j/max_iter;
        [particles(:,i), velocities(:,i)] = generate_new_particles(particles(:,i), velocities(:,i), pbest_path(:,i), gbest_path(i),w, c1, c2, vmax);
        particles(:,i) = saturate_on_boundaries(particles(:,i), xmax, ymax, zmax);
        cost(:,i) = calculate_fitness(particles(:,i), mountains, gbest_path(1:i-1), num_segments, d_safe, radars, delta);
        for k = 1:swarm_size
            if cost(k,i) < pbest_cost(k,i)
                pbest_cost(k,i) = cost(k,i);
                pbest_path(k,i) = particles(k,i);
            end
            if cost(k,i) < gbest_cost(i)
                gbest_cost(i) = cost(k,i);
                gbest_path(i) = particles(k,i);
            end
        end
        [particles(:,i), velocities(:,i), pbest_cost(:,i), pbest_path(:,i), cost(:,i)] = sort_particles(particles(:,i), velocities(:,i), cost(:,i), pbest_cost(:,i), pbest_path(:,i));
        [particles(:,i), velocities(:,i)] = execute_mutation(particles(:,i), velocities(:,i), alpha);
    end
end

%% Plotting

[X,Y] = meshgrid(0:0.1:xmax, 0:ymax);
mountain_size = size(X);
for i = 1:mountain_size(1)
    for j = 1:mountain_size(2)
        Z1(i,j) = mountain_model(mountains(1,1), mountains(2,1), mountains(3,1), mountains(4,1), mountains(5,1), X(i,j), Y(i,j));
        Z2(i,j) = mountain_model(mountains(1,2), mountains(2,2), mountains(3,2), mountains(4,2), mountains(5,2), X(i,j), Y(i,j));
    end
end
surf (X,Y,Z1)
hold on;
ylim([0 ymax]);
xlim([0 xmax]);
zlim([0 zmax]);
view(3);
PositionConstraint = 'outerposition';
ztickformat('%g');
ZAxis.Exponent = 0;
surf (X,Y,Z2)
for i = 1:3
    path = cell2mat(gbest_path(i));
    line(path(1,:),path(2,:),path(3,:), 'Color', rand(1,3), 'LineStyle', '--', 'LineWidth', 2.5)
end
hold off;