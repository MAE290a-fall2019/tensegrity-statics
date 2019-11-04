clear; clc; clf; figure(1);

Theta = (pi/180)*45;

Node0=[-1,0,-1];

Node1=[-1,0,1];

Node2=[1,0,1];

Node3=[1,0,-1];

RotationMatrix = [cos(Theta), 0, -sin(Theta); 0, 1, 0; sin(Theta), 0, cos(Theta)];

Node4= [-1,2,-1] * RotationMatrix;

Node5= [-1,2,1] * RotationMatrix;

Node6= [1,2,1] * RotationMatrix;

Node7= [1,2,-1] * RotationMatrix;

NodeMatrix=[Node0;Node1;Node2;Node3;Node4;Node5;Node6;Node7]

Connectivity1=connectivity(0,6,8);

Connectivity2=connectivity(1,7,8);

Connectivity3=connectivity(2,4,8);

Connectivity4=connectivity(3,5,8);

Connectivity5=connectivity(0,2,8);

Connectivity6=connectivity(1,3,8);

Connectivity7=connectivity(0,5,8);

Connectivity8=connectivity(1,4,8);

Connectivity9=connectivity(1,6,8);

Connectivity10=connectivity(2,5,8);

Connectivity11=connectivity(2,7,8);

Connectivity12=connectivity(3,6,8);

Connectivity13=connectivity(0,7,8);

Connectivity14=connectivity(3,4,8);

Connectivity15=connectivity(5,7,8);

Connectivity16=connectivity(4,6,8);

Connectivity17=connectivity(0,1,8);

Connectivity18=connectivity(1,2,8);

Connectivity19=connectivity(2,3,8);

Connectivity20=connectivity(3,0,8);

Connectivity21=connectivity(0,4,8);

Connectivity22=connectivity(1,5,8);

Connectivity23=connectivity(2,6,8);

Connectivity24=connectivity(3,7,8);

Connectivity25=connectivity(4,5,8);

Connectivity26=connectivity(5,6,8);

Connectivity27=connectivity(6,7,8);

Connectivity28=connectivity(7,4,8);

ConnectivityMatrix=[Connectivity1;Connectivity2;Connectivity3;Connectivity4;Connectivity5;Connectivity6;Connectivity7;Connectivity8;Connectivity9;Connectivity10;Connectivity11;Connectivity12;Connectivity13;Connectivity14;Connectivity15;Connectivity16;Connectivity17;Connectivity18;Connectivity19;Connectivity20;Connectivity21;Connectivity22;Connectivity23;Connectivity24;Connectivity25;Connectivity26;Connectivity27;Connectivity28]


Q=NodeMatrix';

P=[];

 

% INPUTS:

b=4; %bars

s=24; %strings

dim=3; %dimension

q=8; %=locations of free nodes

p=0;%=locations of fixed nodes

C=ConnectivityMatrix;  %=connectivity matrix

U=zeros(dim,q); %=applied external force vector at each free node

U(:,1)=[0;10;0];

U(:,2)=[0;10;0];

U(:,3)=[0;10;0];

U(:,4)=[0;10;0];

U(:,5)=[0;-10;0];

U(:,6)=[0;-10;0];

U(:,7)=[0;-10;0];

U(:,8)=[0;-10;0];


[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);

tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;

