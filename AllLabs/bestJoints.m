function closestJoints = bestJoints(jointArray, initialJoints)
sortme = [];
[n,m] = size(jointArray);

for x = 1:1:n,
    sortme(end +1,:) = abs(jointArray(x, :) - initialJoints);
end


[minn, ind] = min(max(sortme, [], 2), [], 1);

closestJoints = sortme(ind, :);
end