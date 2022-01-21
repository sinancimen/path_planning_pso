function cost = radar_threat_cost(path, x, y, z, r, num_parts, delta)
    cost = 0;
    path_size = size(path(1,:));
    for i = 2: path_size(2)
        for j = 1 : num_parts
            X = (path(:,i)-path(:,i-1)) .* j ./ num_parts + path(:, i-1);
            distance = sqrt((X(1) - x)^2 + (X(2) - y)^2 + (X(3) - z)^2);
            if (distance <= r)
                cost = cost + (delta/distance)^4;
            end
        end
    end
end
