%% Stiffness Method

% Input: D defines the Truss structure as follows
%         D.Ns  -- N x 3  array of node coordinates
%         D.Cs  -- N x 2  array of connector or member mapping           
%         R     -- N x 3  array of node freedom  1 = fixed 0 = free                 
%         D.Us  -- N x 3  array of load force vectors  
%         D.A   -- M x 1  array of member cross section areas
%         D.E   -- M x 1  array of member Elasticity (Youngs Modulous) 
% Ouput: 
%        F    -- M x 1 array of force along members
%        U    -- N x 3 array of Node displacement vectors 
%        R    -- N x 3 array of Reaction force vectors 

function [F,U,R]=ST(D)
w=size(D.R);      % 3 x number of nodes
S=zeros(3*w(2));  % stiffness matrix is 3*(number of nodes) square matrix
U=1-D.R;      % U is displacement  matrix 
            % column index by node 
            % x , y , z by rows 
            % initialize U to 1 for non fixed nodes 0 for fixed
f=find(U);  % f index in U of free nodes 
for i=1:size(D.Cs,2)     % Loop through Connectors (members)
   H=D.Cs(:,i);
   C=D.Ns(:,H(2))-D.Ns(:,H(1));  % C is vector for connector i
   Le=norm(C);                   % Le length of connector i
   T=C/Le;                       % T is unit vector for connector i
   s=T*T';       %   Member Siffness matrix is of form 
                 %   k * |  s  -s |
                 %       |  -s  s | in global truss coordinates  
   G=D.E(i)*D.A(i)/Le;     % G aka k stiffness constant of member = E*A/L
   Tj(:,i)=G*T;            % Stiffness vector of this member
   e=[3*H(1)-2:3*H(1),3*H(2)-2:3*H(2)];  
               % indexes into Global Stiffness matrix S for this member 
   S(e,e)=S(e,e)+G*[s -s;-s s];
               % add this members stiffness to stiffness matrix
end
U(f)=S(f,f)\D.Us(f);   % solve for displacements of free nodes 
                       %  ie solve F = S * U  for U where S is stiffness
                       %  matrix. 
F=sum(Tj.*(U(:,D.Cs(2,:))-U(:,D.Cs(1,:))));
              % project displacement of each node pair on to member
              % between
              % f = Tj dot ( U2j - U1j ).  Then sum over all contributing
              % node pairs.  
R=reshape(S*U(:),w);   % compute forces at all nodes = S*U  
R(f)=0;                % zero free nodes leaving only reaction
end
