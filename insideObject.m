% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function in=insideObject(edge, objects)
    v1=edge(1,:);
    v2=edge(2,:);
    in=0;
    for i=1:length(objects)
        X=objects{i};
        v1_index=-1;
        v2_index=-1;
        for j=1:length(X);
            if(sum((v1-X(j,:)).^2)<0.002)
                v1_index=j;
            end
            if(sum((v2-X(j,:)).^2)<0.002)
                v2_index=j;
            end
        end
        if(v1_index>0 && v2_index>0)
            in=1;
            return;
        elseif(v1_index>0 || v2_index>0)
            in=0;
            return;
        end
        
    end

end