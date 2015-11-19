% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function d = distance(p1, p2)
    X = [p1;p2];
    d = pdist(X, 'Euclidean');
end