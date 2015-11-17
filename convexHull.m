function grown = convexHull(obj, r)
%first append the last element to the front and the front element to the
%end
grown=obj;
obj = vertcat(obj(length(obj),:), obj, obj(1,:));

    for i=2:length(obj)-1
        phi = pi-atan2(obj(i-1,2)-obj(i,2),obj(i-1,1)-obj(i,1));
        Rot_phi = [cos(phi) -sin(phi); sin(phi) cos(phi)];
        nRot_phi = [cos(-phi) -sin(-phi); sin(-phi) cos(-phi)];
        newPnt = (Rot_phi*(obj(i+1,:)-obj(i,:))');
        theta = atan2(newPnt(2),newPnt(1));
        ro = -theta/2;
        nRot_ro = [cos(-ro) -sin(-ro); sin(-ro) cos(-ro)];
        grown(i-1,:) = [0, (-r/cos(theta/2))*sign(theta)];
        grown(i-1,:) = (nRot_phi*nRot_ro*grown(i-1,:)')';
        grown(i-1,:) = grown(i-1,:) + obj(i,:);
    end

end
    