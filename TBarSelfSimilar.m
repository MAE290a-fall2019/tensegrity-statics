clear; clc; clf; figure(1);

Node0=[0,0];

Node1=[1,0.5];

Node2=[1,0];

Node3=[1,-0.5];

Node4= [2,1];

Node5=[2,0];

Node6=[2,-1];

Node7=[3,0.5];

Node8=[3,0];

Node9= [3,-0.5];

Node10=[4,0];

Node11=[0,2];

Node12=[0,-2];

Node13=[-1,0.5];

Node14= [-1,-0.5];

Node15=[-2,1];

Node16=[-2,0];

Node17=[-2,-1];

Node18=[-3,0.5];

Node19= [-3,0];

Node20=[-3,-0.5];

Node21=[-4,0];

Node22=[-1,0];



NodeMatrix=[Node0;Node1;Node2;Node3;Node4;Node5;Node6;Node7;Node8;Node9;Node10;Node11;Node12;Node13;Node14;Node15;Node16;Node17;Node18;Node19;Node20;Node21;Node22]

Connectivity1=connectivity(0,1,23);

Connectivity2=connectivity(0,3,23);

Connectivity3=connectivity(1,4,23);

Connectivity4=connectivity(1,5,23);

Connectivity5=connectivity(3,6,23);

Connectivity6=connectivity(3,5,23);

Connectivity7=connectivity(4,7,23);

Connectivity8=connectivity(6,9,23);

Connectivity9=connectivity(5,7,23);

Connectivity10=connectivity(5,9,23);

Connectivity11=connectivity(7,10,23);

Connectivity12=connectivity(9,10,23);

Connectivity13=connectivity(11,4,23);

Connectivity14=connectivity(12,6,23);

Connectivity15=connectivity(11,15,23);

Connectivity16=connectivity(15,18,23);

Connectivity17=connectivity(18,21,23);

Connectivity18=connectivity(12,17,23);

Connectivity19=connectivity(17,20,23);

Connectivity20=connectivity(20,21,23);

Connectivity21=connectivity(0,13,23);

Connectivity22=connectivity(0,14,23);

Connectivity23=connectivity(13,15,23);

Connectivity24=connectivity(13,16,23);

Connectivity25=connectivity(14,16,23);

Connectivity26=connectivity(14,17,23);

Connectivity27=connectivity(16,18,23);

Connectivity28=connectivity(16,20,23);


Connectivity29=connectivity(0,11,23);

Connectivity30=connectivity(0,12,23);

Connectivity31=connectivity(2,1,23);

Connectivity32=connectivity(2,3,23);

Connectivity33=connectivity(5,4,23);

Connectivity34=connectivity(5,6,23);

Connectivity35=connectivity(8,7,23);

Connectivity36=connectivity(8,9,23);

Connectivity37=connectivity(0,2,23);

Connectivity38=connectivity(2,5,23);

Connectivity39=connectivity(5,8,23);

Connectivity40=connectivity(8,10,23);

Connectivity41=connectivity(0,22,23);

Connectivity42=connectivity(22,13,23);

Connectivity43=connectivity(22,14,23);

Connectivity44=connectivity(22,16,23);

Connectivity45=connectivity(16,15,23);

Connectivity46=connectivity(16,17,23);

Connectivity47=connectivity(16,19,23);

Connectivity48=connectivity(19,18,23);

Connectivity49=connectivity(19,20,23);

Connectivity50=connectivity(19,21,23);


ConnectivityMatrix=[Connectivity1;Connectivity2;Connectivity3;Connectivity4;Connectivity5;Connectivity6;Connectivity7;Connectivity8;Connectivity9;Connectivity10;Connectivity11;Connectivity12;Connectivity13;Connectivity14;Connectivity15;Connectivity16;Connectivity17;Connectivity18;Connectivity19;Connectivity20;Connectivity21;Connectivity22;Connectivity23;Connectivity24;Connectivity25;Connectivity26;Connectivity27;Connectivity28;Connectivity29;Connectivity30;Connectivity31;Connectivity32;Connectivity33;Connectivity34;Connectivity35;Connectivity36;Connectivity37;Connectivity38;Connectivity39;Connectivity40;Connectivity41;Connectivity42;Connectivity43;Connectivity44;Connectivity45;Connectivity46;Connectivity47;Connectivity48;Connectivity49;Connectivity50]

Q=NodeMatrix';

P=[];

% INPUTS:

b=28; %bars

s=22; %strings

dim=2; %dimension

q=23; %=locations of free nodes

p=0;%=locations of fixed nodes

C=ConnectivityMatrix;  %=connectivity matrix

U=zeros(dim,q); %=applied external force vector at each free node

[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);

tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); grid on;

