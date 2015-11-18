function int = intersects(edge1, edge2)
    p = edge1(:,1);
    q = edge2(:,2);
    r = edge1(:,1)-p;
    s = edge2(:,2)-q;
    d = crossprod(r,s);
    if(d==0)
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