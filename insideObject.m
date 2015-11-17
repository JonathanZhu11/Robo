function in=insideObject(edge, objects)
    v1=edge(1,:);
    v2=edge(2,:);
    in=0;
    for i=1:length(objects)
        X=objects{i};
        v1_index=-1;
        v2_index=-1;
        for j=1:length(X);
            if(v1==X(j,:))
                v1_index=j;
            end
            if(v2==X(j,:))
                v2_index=j;
            end
        end
        if(v1_index>0 && v2_index>0)
            location=mod((v1_index+v2_index),length(X));
            if(location==1 || location==length(X)-1)
                in=0;
            else
                in=1;
            end
            return;
        elseif(v1_index>0 || v2_index>0)
                in=1;
                return;
        end
        
    end

end