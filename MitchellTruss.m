clear; clc; clf; figure(1);

Alpha=sin(pi()/6)/sin((pi()/6)+pi()/16); %alpha

Phi=pi()/16;

Radii0=2;

Radii1=Alpha*Radii0;

Radii2=Alpha*Radii1;

Radii3=Alpha*Radii2;

Radii4=Alpha*Radii3;

Node0=[2,0];

Node1=[Radii1*cos(Phi),Radii1*sin(Phi)];

Node2=[Radii1*cos(Phi),-Radii1*sin(Phi)];

Node3=[Radii2*cos(2*Phi),Radii2*sin(2*Phi)];

Node4=[Radii2,0];

Node5=[Radii2*cos(2*Phi),-Radii2*sin(2*Phi)];

Node6=[Radii3*cos(3*Phi),Radii3*sin(3*Phi)];

Node7=[Radii3*cos(Phi),Radii3*sin(Phi)];

Node8=[Radii3*cos(Phi),-Radii3*sin(Phi)];

Node9=[Radii3*cos(3*Phi),-Radii3*sin(3*Phi)];

Node10=[Radii4*cos(4*Phi),Radii4*sin(4*Phi)];

Node11=[Radii4*cos(2*Phi),Radii4*sin(2*Phi)];

Node12=[Radii4,0];

Node13=[Radii4*cos(2*Phi),-Radii4*sin(2*Phi)];

Node14=[Radii4*cos(4*Phi),-Radii4*sin(4*Phi)];

NodeMatrix=[Node0;Node1;Node2;Node3;Node4;Node5;Node6;Node7;Node8;Node9;Node10;Node11;Node12;Node13;Node14];

Connectivity1=connectivity(1,0,15);

Connectivity2=connectivity(2,0,15);

Connectivity3=connectivity(3,1,15);

Connectivity4=connectivity(4,1,15);

Connectivity5=connectivity(4,2,15);

Connectivity6=connectivity(5,2,15);

Connectivity7=connectivity(6,3,15);

Connectivity8=connectivity(7,3,15);

Connectivity9=connectivity(7,4,15);

Connectivity10=connectivity(8,4,15);

Connectivity11=connectivity(8,5,15);

Connectivity12=connectivity(9,5,15);

Connectivity13=connectivity(10,6,15);

Connectivity14=connectivity(11,6,15);

Connectivity15=connectivity(11,7,15);

Connectivity16=connectivity(12,7,15);

Connectivity17=connectivity(12,8,15);

Connectivity18=connectivity(13,8,15);

Connectivity19=connectivity(13,9,15);

Connectivity20=connectivity(14,9,15);

ConnectivityMatrix=[Connectivity1;Connectivity2;Connectivity3;Connectivity4;Connectivity5;Connectivity6;Connectivity7;Connectivity8;Connectivity9;Connectivity10;Connectivity11;Connectivity12;Connectivity13;Connectivity14;Connectivity15;Connectivity16;Connectivity17;Connectivity18;Connectivity19;Connectivity20]

Q=NodeMatrix(1:10,:)';

P=NodeMatrix(11:15,:)';

 

% INPUTS:

b=20;% number of bars

s=0;% number of strings

dim=2; % two dimensional system

q=10; %=locations of free nodes

p=5 ;%=locations of fixed nodes

C=ConnectivityMatrix;  %=connectivity matrix

U=zeros(dim,q); %=applied external force vector at each free node

U(:,1)=[10;10];
U(:,2)=[10;10];
U(:,3)=[0;10];
U(:,4)=[5;10];
U(:,5)=[-5;10];
U(:,6)=[-10;10];
U(:,7)=[-10;10];
U(:,8)=[-5;10];
U(:,9)=[0;10];
U(:,10)=[-10;10];

[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);

tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;