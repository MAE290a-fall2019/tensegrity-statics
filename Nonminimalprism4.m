clear; clf; figure(1);clc;

alpha = pi/1.5; h = 1; r = 0.5; poly = 4;
Q(:,1) = [r;r;0];
Q(:,2) = [-r;r;0];
Q(:,3) = [-r;-r;0];
Q(:,4) = [r;-r;0];
rot = [cos(alpha),-sin(alpha),0;
    sin(alpha),cos(alpha),0;
    0, 0, 1];
Q(:,5:8) = rot*Q(:,1:4);
Q(3,5:8) = Q(3,1:4)+ ones(1,4)*h;
P= [];
[dim,q] = size(Q); p = size(P,2); n = q+p;



% Connectivity matrix
C(  1,1)=1; C(  1,5)=-1;       % bars 
C(  2,2)=1; C(  2,6)=-1;
C(  3,3)=1; C(  3,7)=-1;
C(  4,4)=1; C(  4,8)=-1;b=poly;

% vertical
C(b+1,1)=1; C(b+1,8)=-1;       % strings 
C(b+2,2)=1; C(b+2,5)=-1;    
C(b+3,3)=1; C(b+3,6)=-1;    
C(b+4,4)=1; C(b+4,7)=-1;
% diagonal
C(b+5,1)=1; C(b+5,7)=-1;    
C(b+6,2)=1; C(b+6,8)=-1;    
C(b+7,3)=1; C(b+7,5)=-1;    
C(b+8,4)=1; C(b+8,6)=-1;
% diagonal
C(b+17,1)=1; C(b+17,6)=-1;    
C(b+18,2)=1; C(b+18,7)=-1;    
C(b+19,3)=1; C(b+19,8)=-1;    
C(b+20,4)=1; C(b+20,5)=-1;
% bottom
C(b+9,1)=1; C(b+9,2)=-1;       % strings 
C(b+10,2)=1; C(b+10,3)=-1;    
C(b+11,3)=1; C(b+11,4)=-1;    
C(b+12,4)=1; C(b+12,1)=-1;
% top 
C(b+13,5)=1; C(b+13,6)=-1;       % strings 
C(b+14,6)=1; C(b+14,7)=-1;    
C(b+15,7)=1; C(b+15,8)=-1;    
C(b+16,8)=1; C(b+16,5)=-1;s= size(C,1)-b; m=b+s;

% Applied external force U=U_(dim x q)
U= zeros(dim,q); U(3,1)=-1; U(3,2)=-1;  U(3,3)=-1; U(3,4)=-1; U(3,5)=1;  U(3,6)=1; U(3,7)=1;  U(3,8)=1;
%U(2,1)=-2; U(1,2)=-1;  U(2,3)=-1; U(1,4)=-3; U(2,5)=2;  U(1,6)=2; U(1,7)=2;  U(2,8)=1;
U = U.* 3;
% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;

% end script TBar3
