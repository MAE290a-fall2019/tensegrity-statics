%% Non-Minimal Tensegrity Prism with 4 bars
close all
clear
clc

% Parameters --------------------------------------------------------------
b     = 4;
s     = 16;
p     = 4;
q     = 4;
n     = q+p;
m     = s+b;
dim   = 3;
h     = 5;     % height
d1    = 2;     % distance for the lateral in the base 
d2    = 1;     % distance for the lateral in the top 
theta = -pi/4; % the rotation angle of the smaller square, positive as couterclockwise

% Computation of Q, P, N, C and U -----------------------------------------
T1(1,:) = [cos(pi/2) -sin(pi/2) 0];
T1(2,:) = [sin(pi/2) cos(pi/2)  0];
T1(3,:) = [0 0 1];
T2(1,:) = [cos(theta) -sin(theta) 0];
T2(2,:) = [sin(theta) cos(theta)  0];
T2(3,:) = [0 0 1];

P = zeros(3,p);
Q = zeros(3,q);
P(:,1) = [-d1;d1;0];
P(:,2) = T1*P(:,1) ;
P(:,3) = T1*P(:,2);
P(:,4) = T1*P(:,3); 
Q(:,1) = T2*[-d2;d2;h];
Q(:,2) = T1*Q(:,1);
Q(:,3) = T1*Q(:,2);
Q(:,4) = T1*Q(:,3);
N=[Q P];

C = zeros(m,n);
% Bars
C(1,1) = 1;  C(1,7) = -1;
C(2,2) = 1;  C(2,8) = -1;
C(3,3) = 1;  C(3,5) = -1;
C(4,4) = 1;  C(4,6) = -1;
% Strings
C(5,1) = 1;  C(5,2)  = -1;
C(6,2) = 1;  C(6,3)  = -1;
C(7,3) = 1;  C(7,4)  = -1;
C(8,4) = 1;  C(8,1)  = -1;
C(9,5)  = 1; C(9,6)  = -1;
C(10,6) = 1; C(10,7) = -1;
C(11,7) = 1; C(11,8) = -1;
C(12,8) = 1; C(12,5) = -1;
C(13,1) = 1; C(13,5) = -1;
C(14,1) = 1; C(14,6) = -1;
C(15,2) = 1; C(15,6) = -1;
C(16,2) = 1; C(16,7) = -1;
C(17,3) = 1; C(17,7) = -1;
C(18,3) = 1; C(18,8) = -1;
C(19,4) = 1; C(19,5) = -1;
C(20,4) = 1; C(20,8) = -1;

% Load 
factor=10;
U = zeros(dim,p);
U(1:3,1) = factor*[0 0 1];
U(1:3,2) = factor*[1 0 1];
U(1:3,3) = factor*[-1 0 1];
U(1:3,4) = factor*[0 0 -1];

% Static state ------------------------------------------------------------
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); 


%%  DIRECT STIFFNESS METHOD

% Construction of Ns Cs Us R A E (see ST.m) -------------------------------

% Nodal coordinates
Ns=[N'];

for i=1:s+b
    for j=1:q+p
        if C(i,j)==1      % Beggining of the bar or string
            j_ini(i)=j; 
        elseif C(i,j)==-1 % End of the bar or string
            j_end(i)=j;
        end
    end
    Cs(i,1:2)=[j_ini(i) j_end(i)];
end

% Definition of Degree of freedom (free=0 &  fixed=1), for 2-D trusses 
% the last column is equal to 1
R=zeros(size(Ns));
for i=1:p
    R(q+i,:)=[1 1 1];
end

% Definition of Nodal loads 
Us=zeros(size(Ns));
for i=1:q
    Us(i,:)=[U(1,i) U(2,i) 0];
end

% Definition of Modulus of Elasticity
E=ones(1,size(Cs,1))*1e7;

% Definition of Area
A=(pi*(1e-2)^2)*ones(1,s+b);

% Creating the input structure
D.Ns = Ns';
D.Cs = Cs';
D.R  = R';
D.Us = Us';
D.E  = E';
D.A  = A';
D.R  = R';
D.Cs = Cs';

% Calculate displacements and plot ----------------------------------------
[F,U,R] = ST(D);
TP(D,U,20);
