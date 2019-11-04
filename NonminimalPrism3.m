% Static force analysis of 4-bar non-minimal tensigrity prism (Fig 4.6 of Skelton & de Oliviera 2009)
% By Shuhang Zhang, UC San Diego student 2019.
clear; clf; clc; figure(1);

% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
a = 1; h = 3; Alpha = pi/6;

Q(:,1)=a*[ -1; 0; 0];
Q(:,2)=a*[ cos(pi/3); sin(pi/3); 0];
Q(:,3)=a*[ cos(pi/3);-sin(pi/3); 0];


R = [cos(Alpha),-sin(Alpha),0;
    sin(Alpha),cos(Alpha),0;
    0,0,1];

Q(:,4)=a*R*[ -1; 0; 0]+[0;0;h];
Q(:,5)=a*R*[ cos(pi/3); sin(pi/3); 0]+[0;0;h];
Q(:,6)=a*R*[ cos(pi/3);-sin(pi/3); 0]+[0;0;h];


P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,6)=-1;       % bars 
C(  2,2)=1; C(  2,4)=-1;
C(  3,3)=1; C(  3,5)=-1;
 b=3;

C(b+1,1)=1; C(b+1,4)=-1;       % strings 
C(b+2,2)=1; C(b+2,5)=-1;    
C(b+3,3)=1; C(b+3,6)=-1;    


C(b+4,1)=1; C(b+4,2)=-1;    
C(b+5,2)=1; C(b+5,3)=-1;    
C(b+6,3)=1; C(b+6,1)=-1; 

C(b+7,4)=1; C(b+7,5)=-1; 
C(b+8,5)=1; C(b+8,6)=-1; 
C(b+9,6)=1; C(b+9,4)=-1; 


C(b+10,1)=1; C(b+10,5)=-1; 
C(b+11,2)=1; C(b+11,6)=-1; 
C(b+12,3)=1; C(b+12,4)=-1; 


 

s=12; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:q)=0; 
 U(1,1)=-0.2;U(1,2)=0.1;U(1,3)=0.1;
 U(3,4)=-0.1;U(3,5)=-0.1;U(3,6)=-0.1;
  U(3,1)= 0.1;U(3,2)= 0.1;U(3,3)= 0.1;
%   U=-U;
% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2); grid on;

% end script NonminimalPrism4