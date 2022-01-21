function particles = logistic_map(initial_pos, goal_pos, num_particles, num_parts, mu, x, y, z)
   initial_x = initial_pos(1);
   initial_y = initial_pos(2)/y;
   initial_z = initial_pos(3)/z;
   goal_x = goal_pos(1);
   goal_y = goal_pos(2)/y;
   goal_z = goal_pos(3)/z;
   initialized = false;
   new_particle = true;
   path = [];
   particles = cell(num_particles,1);

   for i = 1:num_particles
       for j = 2 : num_parts
            if (initialized == false)
                last_y(j) = initial_y + (j-1) / (num_parts) * (goal_y - initial_y);
                last_z(j) = initial_z + (j-1) / (num_parts) * (goal_z - initial_z);
                path(2,j) = last_y(j);
                path(3,j) = last_z(j);
                path(1,j) = (j-1)/num_parts;
                if (j == num_parts)
                    initialized = true;
                end
            else
                last_y(j) = mu * last_y(j) * (1 - last_y(j));
                last_z(j) = mu * last_z(j) * (1 - last_z(j));
                path(2,j) = last_y(j);
                path(3,j) = last_z(j);
                path(1,j) = (j-1)/num_parts;
            end
       end
       path(1,1) = 0;
       path(1,num_parts+1) = goal_x / x;
       path(2,num_parts+1) = goal_y;
       path(3,num_parts+1) = goal_z;
       path(2,1) = initial_y;
       path(3,1) = initial_z;
       path(1,:) = (goal_x - initial_x) * path(1,:) + initial_x;
       path(2,:) = y * path(2,:);
       path(3,:) = z * path(3,:);
       particles(i,1) = mat2cell(path(:,:), 3, num_parts+1);
   end
end