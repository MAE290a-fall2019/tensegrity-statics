% Static force analysis of 2D TBar (Fig 3.3 of Skelton & de Oliviera 2009)
% By Thomas Bewley, UC San Diego (+ faculty fellow at JPL)
clear; clf; figure(1);

theta = 45*pi/180;
r = [cos(theta),0,-sin(theta);0,1,0;sin(theta),0,cos(theta)];
% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x q)] node locations
Q(:,1)=[-1,0,-1];
Q(:,2)=[-1,0,1];
Q(:,3)=[1,0,1];
Q(:,4)=[1,0,-1];
Q(:,5)=[-1,2,-1]*r;
Q(:,6)=[-1,2,1]*r;
Q(:,7)=[1,2,1]*r;
Q(:,8)=[1,2,-1]*r;
P=[];
%Q=Q';
[dim,q]=size(Q); p=size(P,2); n=q+p; 

C(:,1)=conVect(1,7,8);
C(:,2)=conVect(2,8,8);
C(:,3)=conVect(3,5,8);
C(:,4)=conVect(4,6,8); b = 4;
%C(:,5)=conVect(1,3,8);
%C(:,6)=conVect(2,4,8);
C(:,5)=conVect(1,6,8);
C(:,6)=conVect(2,5,8);
C(:,7)=conVect(2,7,8);
C(:,8)=conVect(3,6,8);
C(:,9)=conVect(3,8,8);
C(:,10)=conVect(4,7,8);
C(:,11)=conVect(1,8,8);
C(:,12)=conVect(4,5,8);
%C(:,15)=conVect(6,8,8);
%C(:,16)=conVect(5,7,8);
C(:,13)=conVect(1,2,8);
C(:,14)=conVect(2,3,8);
C(:,15)=conVect(3,4,8);
C(:,16)=conVect(4,1,8);
C(:,17)=conVect(1,5,8);
C(:,18)=conVect(2,6,8);
C(:,19)=conVect(3,7,8);
C(:,20)=conVect(4,8,8);
C(:,21)=conVect(5,6,8);
C(:,22)=conVect(6,7,8);
C(:,23)=conVect(7,8,8);
C(:,24)=conVect(8,5,8); s = 20;
%{
% Connectivity matrix
C(  1,1)=1; C(  1,2)=-1;       % bars 
C(  2,2)=1; C(  2,3)=-1;
C(  3,2)=1; C(  3,4)=-1;
C(  4,2)=1; C(  4,5)=-1;
C(  5,2)=1; C(  5,6)=-1; b=5;
C(b+1,1)=1; C(b+1,4)=-1;       % strings 
C(b+2,1)=1; C(b+2,5)=-1;    
C(b+3,1)=1; C(b+3,6)=-1;    
C(b+4,3)=1; C(b+4,4)=-1;    
C(b+5,3)=1; C(b+5,5)=-1;    
C(b+6,3)=1; C(b+6,6)=-1;    
C(b+7,4)=1; C(b+7,5)=-1;    
C(b+8,5)=1; C(b+8,6)=-1;    
C(b+9,6)=1; C(b+9,4)=-1; s=9; m=b+s;
%}
C = C';
% Applied external force U=U_(dim x q)
U(1:dim,1:q)=0;
%U(1,1)=1; U(1,3)=-1;
U(:,1) = [0; 10; 0];
U(:,2) = [0; 10; 0];
U(:,3) = [0; 10; 0];
U(:,4) = [0; 10; 0];
U(:,5) = [0; -10; 0];
U(:,6) = [0; -10; 0];
U(:,7) = [0; -10; 0];
U(:,8) = [0; -10; 0];

% Solve for the forces at equilibrium, and plot
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,1,0.08); grid on;

function C_vect = conVect(start,finish,total_nodes)
C_vect = zeros(1,total_nodes);
C_vect(1,start) = -1;
C_vect(1,finish) = 1;
return
end
% end script TBar3