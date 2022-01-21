function [particles,velocities] = execute_mutation(particles, velocities, alpha)
    particle_list_size = size(particles);
    half_size = particle_list_size(1)/2;
    particle_size = size(cell2mat(particles(1,1)));
    waypoint_size = particle_size(2);
    for i = 1:half_size
        small_particle = cell2mat(particles(i));
        for j = 2:waypoint_size-1
            small_particle(2,j) = small_particle(2,j) + alpha * rand;
            small_particle(3,j) = small_particle(3,j) + alpha * rand;
        end
        particles(i+half_size) = mat2cell(small_particle, 3, waypoint_size);
        velocities(i+half_size) = velocities(i);
    end
end

