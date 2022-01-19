function [new_particles, velocities] = generate_new_particles(particles, velocities, pbest_path, gbest_path, w, c1, c2, vmax)
    swarm_size = size(particles);
    for i = 1 : swarm_size(1)
        unsaturated_velocity = w * cell2mat(velocities(i)) + c1 * rand * (cell2mat(pbest_path(i)) - cell2mat(particles(i))) + c2 * rand * (cell2mat(gbest_path) - cell2mat(particles(i)));
        saturated_velocity = min(vmax, max(-vmax, unsaturated_velocity));
        velocities(i) = mat2cell(saturated_velocity, 3, 41);
        new_particles(i) = mat2cell(cell2mat(particles(i)) + cell2mat(velocities(i)), 3, 41);
    end
end