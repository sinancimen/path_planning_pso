function cost = path_length_cost(path)
    sum = 0;
    for i = 2 : size(path)
        sum = sum + sqrt((path(1,i) - path(1,i-1))^2 + (path(2,i) - path(2,i-1))^2 + (path(3,i) - path(3,i-1))^2);
    end
    shortest_length = sqrt((path(1, end) - path(1, 1))^2 + (path(2, end) - path(2,1))^2 + (path(3,end) - path(3,1))^2);
    cost = sum/shortest_length;
end