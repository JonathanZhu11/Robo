function d = distance(p1, p2)
    X = [p1;p2];
    d = pdist(X, 'Euclidean');
end