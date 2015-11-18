function newObject = convexHull(object, r)
%first append the last element to the front and the front element to the
%end
newObject=object;
object = vertcat(object(length(object),:), object, object(1,:));

for i=2:length(object)-1
    phi = pi-atan2(object(i-1,2)-object(i,2),object(i-1,1)-object(i,1));
    Rot_phi = [cos(phi) -sin(phi); sin(phi) cos(phi)];
    nRot_phi = [cos(-phi) -sin(-phi); sin(-phi) cos(-phi)];
    newPnt = (Rot_phi*(object(i+1,:)-object(i,:))');
    theta = atan2(newPnt(2),newPnt(1));
    ro = -theta/2;
    nRot_ro = [cos(-ro) -sin(-ro); sin(-ro) cos(-ro)];
    newObject(i-1,:) = [0, (-r/cos(theta/2))*sign(theta)];
    newObject(i-1,:) = (nRot_phi*nRot_ro*newObject(i-1,:)')';
    newObject(i-1,:) = newObject(i-1,:) + object(i,:);
end

end
    