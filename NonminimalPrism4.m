% Static force analysis of 4-bar non-minimal tensigrity prism (Fig 4.6 of Skelton & de Oliviera 2009)
% By Shuhang Zhang, UC San Diego student 2019.
clear; clf;clc; figure(1);

% Free [Q=Q_(dim x q)] and fixed [P=P_(dim x p)] node locations
a = 1; h = 2.4; Alpha = pi/4;

Q(:,1)=a*[-0.5;-0.5; 0];
Q(:,2)=a*[ 0.5;-0.5; 0];
Q(:,3)=a*[ 0.5; 0.5; 0];
Q(:,4)=a*[-0.5; 0.5; 0];

R = [cos(Alpha),-sin(Alpha),0;
    sin(Alpha),cos(Alpha),0;
    0,0,1];

Q(:,5)=a*R*[-0.5;-0.5; 0]+[0;0;h];
Q(:,6)=a*R*[ 0.5;-0.5; 0]+[0;0;h];
Q(:,7)=a*R*[ 0.5; 0.5; 0]+[0;0;h];
Q(:,8)=a*R*[-0.5; 0.5; 0]+[0;0;h];

P=[];
[dim,q]=size(Q); p=size(P,2); n=q+p; 

% Connectivity matrix
C(  1,1)=1; C(  1,7)=-1;       % bars 
C(  2,2)=1; C(  2,8)=-1;
C(  3,3)=1; C(  3,5)=-1;
C(  4,4)=1; C(  4,6)=-1; b=4;

C(b+1,1)=1; C(b+1,2)=-1;       % strings 
C(b+2,2)=1; C(b+2,3)=-1;    
C(b+3,3)=1; C(b+3,4)=-1;    
C(b+4,4)=1; C(b+4,1)=-1; 

C(b+5,5)=1; C(b+5,6)=-1;    
C(b+6,6)=1; C(b+6,7)=-1;    
C(b+7,7)=1; C(b+7,8)=-1;    
C(b+8,8)=1; C(b+8,5)=-1; 


C(b+9,1)=1; C(b+9,6)=-1;    
C(b+10,2)=1; C(b+10,7)=-1;    
C(b+11,3)=1; C(b+11,8)=-1;    
C(b+12,4)=1; C(b+12,5)=-1; 

C(b+13,1)=1; C(b+13,5)=-1;    
C(b+14,2)=1; C(b+14,6)=-1;    
C(b+15,3)=1; C(b+15,7)=-1;    
C(b+16,4)=1; C(b+16,8)=-1; 

C(b+17,1)=1; C(b+17,8)=-1;    
C(b+18,2)=1; C(b+18,5)=-1;    
C(b+19,3)=1; C(b+19,6)=-1;    
C(b+20,4)=1; C(b+20,7)=-1; 

s=20; m=b+s;

% Applied external force U=U_(dim x q)
U(1:dim,1:q)=0; 
U(3,1)= 0.1;U(3,2)= 0.1;U(3,3)= 0.1;U(3,4)= 0.1;
U(3,5)=-0.1;U(3,6)=-0.1;U(3,7)=-0.1;U(3,8)=-0.1;


  U=-U;
U
% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1); grid on;

% end script NonminimalPrism4