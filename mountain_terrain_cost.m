function cost = mountain_terrain_cost(path, obstacles, num_parts)
    cost = 0;
    path_size = size(path(1,:));
    obstacle_num = size(obstacles);
    for i = 2: path_size(2)
        for j = 1 : num_parts
            X = (path(:,i)-path(:,i-1)) .* j ./ num_parts + path(:, i-1);
            for k = 1: obstacle_num(2)
                height = mountain_model(obstacles(1, k), obstacles(2,k), obstacles(3,k), obstacles(4,k), obstacles(5,k), X(1), X(2));
                if (height >= X(3))
                    cost = cost + 1;
                end
            end
        end
    end
end