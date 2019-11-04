%% Plot the result of the Direct Stiffness Method
function X=TP(D,U,Sc)
C=[D.Ns;D.Ns+Sc*U];
e=D.Cs(1,:);
f=D.Cs(2,:);
for i=1:6
    M=[C(i,e);C(i,f); repmat(NaN,size(e))];
    X(:,i)=M(:);    
end
plot3(X(:,4),X(:,5),X(:,6),'g-');hold on
plot3(X(:,4),X(:,5),X(:,6),'k--');

axis('equal');
if D.R(3,:)==1
    view(2);
end
end
