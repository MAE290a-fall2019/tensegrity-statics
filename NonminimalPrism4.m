%% Non-Minimal Tensegrity Prism with 4 bars
close all
clear
clc

% Parameters --------------------------------------------------------------
b     = 4;
s     = 16;
p     = 0;
q     = 8;
n     = q+p;
m     = s+b;
dim   = 3;
h     = 2;     % height
d1    = 1;     % distance for the lateral in the base 
d2    = 1.5;     % distance for the lateral in the top 
theta = -pi/16; % the rotation angle of the smaller square, positive as couterclockwise

% Computation of Q, P, N, C and U -----------------------------------------
T1(1,:) = [cos(pi/2) -sin(pi/2) 0];
T1(2,:) = [sin(pi/2) cos(pi/2)  0];
T1(3,:) = [0 0 1];
T2(1,:) = [cos(theta) -sin(theta) 0];
T2(2,:) = [sin(theta) cos(theta)  0];
T2(3,:) = [0 0 1];

Q = zeros(3,q);
Q(:,1) = [-d1;d1;0];
Q(:,2) = T1*Q(:,1) ;
Q(:,3) = T1*Q(:,2);
Q(:,4) = T1*Q(:,3); 
Q(:,5) = T2*[-d2;d2;h];
Q(:,6) = T1*Q(:,5);
Q(:,7) = T1*Q(:,6);
Q(:,8) = T1*Q(:,7);
P = [];
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
U = zeros(dim,q);
for i=1:4
    U(3,i)   = -1;
    U(3,4+i) = +1;
end

% Static state ------------------------------------------------------------
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0); 


