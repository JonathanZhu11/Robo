function int = intersects(edge1, edge2)
    p = edge1(1,:);
    q = edge2(1,:);
    
    r = edge1(2,:)-p;
    s = edge2(2,:)-q;
    
    d = cross(r,s);
    if(abs(d)<0.0002)
        int=0;
    else
        t = crossprod(q-p,s)/d;
        u = crossprod(q-p,r)/d;
        if(t>0.0001 && t<.9999 && u>0.0001 && u<.9999)
            int=1;
        else
            int=0;
        end
    end
end

function c = cross(u,v)
    c=det([u;v]);
end