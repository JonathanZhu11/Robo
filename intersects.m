% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function int = intersects(edge1, edge2)
    p = edge1(1,:);
    q = edge2(1,:);
    r = edge1(2,:)-p;
    s = edge2(2,:)-q;
    d = crossprod(r,s);
    if(abs(d)<0.0002)
        int=0;
    else
        t = crossprod(q-p,s)/d;
        u = crossprod(q-p,r)/d;
        if(t>0 && t<1 && u>0 && u<1)
            int=1;
        else
            int=0;
        end
    end
end

function c = crossprod(x,y)
    c=x(1)*y(2)-x(2)*y(1);
end