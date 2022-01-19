function cost = collision_cost(path, other_paths, num_parts,safe_distance)
    cost = 0;
    path_size = size(path(1,:));
    size_other_paths = size(other_paths);
    X_other_list = cell2mat(other_paths);
    path_size_2 = path_size(2);
    for i = 2: path_size_2
        for j = 1 : num_parts
            X = (path(:,i)-path(:,i-1)) .* j ./ num_parts + path(:, i-1);
            for k = 1 : size_other_paths(2)
                for n = 1 : path_size_2
                    X_other = X_other_list(:,n+path_size_2*(k-1));
                    distance = sqrt((X(1)-X_other(1))^2 + (X(2)-X_other(2))^2 + X(3)-X_other(3));
                    if (distance<safe_distance)
                        cost = cost + 1;
                    end
                end
            end
        end
    end
end