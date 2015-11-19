% Team 15
% Jonathan Zhu jhz2110@columbia.edu
% Adam Richardson ajr2190@columbia.edu
% Lennart Graf von Hardenberg lcg2132@columbia.edu

% Homework 4 Solution - Nov-16-2015

function objects = getObjectData(filename)
    fileID=fopen(filename,'r');
    data = fscanf(fileID,'%f');
    fclose(fileID);
    numObjects=data(1);
    objects=cell(numObjects,1);
    index=2;
    for i=1:numObjects
        size=data(index);
        index=index+1;
        A = zeros(2);
        for j=1:size
            A(j,1)=data(index);
            A(j,2)=data(index+1);
            index=index+2;
        end
        objects{i}=A;
    end

end