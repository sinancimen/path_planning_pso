function particles = saturate_on_boundaries(particles, xmax, ymax, zmax)
    swarm_size = size(particles);
    particle_size = size(cell2mat(particles(1)));
    waypoint_number = particle_size(2);
    for i = 1:swarm_size(1)
        p_particle = cell2mat(particles(i));
        for j = 1:waypoint_number
            p_particle(1,j) = min(xmax, max(0, p_particle(1,j)));
            p_particle(2,j) = min(ymax, max(0, p_particle(2,j)));
            p_particle(3,j) = min(zmax, max(0, p_particle(3,j)));
        end
        particles(i) = mat2cell(p_particle, 3, waypoint_number);
    end
end

