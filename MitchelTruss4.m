% Static force analysis of 2D Mitchel Truss 4 (Fig 4.6 of Skelton & de Oliviera 2009)
% By Shuhang Zhang, UC San Diego student 2019.
clear; clf;clc; figure(1);

% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
Fai = pi/8; Beta = pi/6;
r=10*logspace(1,(sin(Beta)/sin(Beta+Fai))^5,5);
Q(:,1)=r(1)*[1; 0];
Q(:,2)=r(2)*[cos(Fai); sin(Fai)];Q(:,3)=r(2)*[cos(Fai); -sin(Fai)];

Q(:,4)=r(3)*[cos(2*Fai); sin(2*Fai)];Q(:,5)=r(3)*[cos(2*Fai); -sin(2*Fai)];Q(:,6)=r(3)*[1;0];

Q(:,7)=r(4)*[cos(Fai); sin(Fai)];Q(:,8)=r(4)*[cos(Fai); -sin(Fai)];
Q(:,9)=r(4)*[cos(3*Fai); sin(3*Fai)];Q(:,10)=r(4)*[cos(3*Fai); -sin(3*Fai)];

P(:,1)=r(5)*[cos(4*Fai),sin(4*Fai)];P(:,2)=r(5)*[cos(4*Fai),-sin(4*Fai)];
P(:,3)=r(5)*[cos(2*Fai),sin(2*Fai)];P(:,4)=r(5)*[cos(2*Fai),-sin(2*Fai)];
P(:,5)=r(5)*[1,0];

[dim,q]=size(Q), p=size(P,2), n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,3)=-1;       % bars 
C(  2,3)=1; C(  2,5)=-1;    
C(  3,5)=1; C(  3,10)=-1;                                              
C( 4,10)=1; C(  4,q+2)=-1;
C(  5,2)=1; C(  5,6)=-1;

C(  6,6)=1; C(  6,8)=-1;
C(  7,8)=1; C(  7,q+4)=-1;
C(  8,4)=1; C(  8,7)=-1;
C(  9,7)=1; C(  9,q+5)=-1;
C( 10,9)=1; C( 10,q+3)=-1;

b=10;   


C(b+1,1)=1; C(b+1,2)=-1;       % strings 
C(b+2,2)=1; C(b+2,4)=-1;    
C(b+3,4)=1; C(b+3,9)=-1;                                              
C(b+4,9)=1; C(b+4,q+1)=-1;
C(b+5,3)=1; C(b+5,6)=-1;

C(b+6,6)=1; C(b+6,7)=-1;
C(b+7,7)=1; C(b+7,q+3)=-1;
C(b+8,5)=1; C(b+8,8)=-1;
C(b+9,8)=1; C(b+9,q+5)=-1;
C(b+10,10)=1; C(b+10,q+4)=-1;  
s=10; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:q)=0; 
U(2,1)=-sin(pi/6); U(1,1)=-cos(pi/6); 
% U(2,1)=-1;
%  U=-U;
U


% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1); grid on;

% end script  MitchelTruss4

