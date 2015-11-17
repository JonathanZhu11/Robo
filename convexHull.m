function Xprime = convexHull(X, r)
%first append the last element to the front and the front element to the
%end
Xprime=X;
X = vertcat(X(length(X),:), X, X(1,:));

for i=2:length(X)-1
    phi = pi-atan2(X(i-1,2)-X(i,2),X(i-1,1)-X(i,1));
    Rot_phi = [cos(phi) -sin(phi); sin(phi) cos(phi)];
    nRot_phi = [cos(-phi) -sin(-phi); sin(-phi) cos(-phi)];
    newPnt = (Rot_phi*(X(i+1,:)-X(i,:))');
    theta = atan2(newPnt(2),newPnt(1));
    ro = -theta/2;
    nRot_ro = [cos(-ro) -sin(-ro); sin(-ro) cos(-ro)];
    Xprime(i-1,:) = [0, (-r/cos(theta/2))*sign(theta)];
    Xprime(i-1,:) = (nRot_phi*nRot_ro*Xprime(i-1,:)')';
    Xprime(i-1,:) = Xprime(i-1,:) + X(i,:);
end

end
    