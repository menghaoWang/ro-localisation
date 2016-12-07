function dis = distance(p1,p2)
b = (size(p1) == size(p2));
if ~isequal(b,[1,1])
    error('function->distance:matrix size should be equal');
end
if (size(p1,1)~= 1 && size(p1,2)~= 1)
    error('function->distance:input arg should be a vector');
end
dis = norm(p1 - p2);