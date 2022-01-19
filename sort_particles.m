function [particles, velocities, pbest_cost, pbest_path, costs] = sort_particles(particles, velocities, costs, pbest_cost, pbest_path);
    [costs, sortIdx] = sort(costs, 'ascend');
    particles = particles(sortIdx);
    velocities = velocities(sortIdx);
    pbest_cost = pbest_cost(sortIdx);
    pbest_path = pbest_path(sortIdx);
end

