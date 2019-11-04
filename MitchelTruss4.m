%% MICHELL TRUSS STRUCTURE ORDER 4
close all
clear 
clc

% Parameters --------------------------------------------------------------
b     = 20;
s     = 0;
p     = 5;
q     = 10;
n     = q+p;
m     = s+b;
phi   = pi/16; 
beta  = pi/6; 
order = 4;
dim   = 2;
a     = sin(beta)/sin(beta + phi);
c     = sin(phi)/sin(beta + phi);
r     = ones(order+1,1);

% Computation of Q, P, N, C and U -----------------------------------------

for i=1:5
   r(i+1)=r(i)*a;
end
iComplex = sqrt(-1);
for i1=0:order
    for i2=0:order-i1
       NN(i1+1,i2+1)=r(i1+i2+1)*exp(iComplex*((i1-i2)*phi));
    end
end
PP = zeros(1,p);
QQ = [];
for i = 1:p
    j = p+1-i;
    PP(i) = NN(i,j);
end
for k = p:-1:2
    for i = 1:k-1
        j = k-i;
        QQ = [QQ NN(i,j)];
    end
end
Q = [real(QQ);imag(QQ)];
P = [real(PP);imag(PP)];
N = [Q P];

% Conection between elements (only bars)
C(1,11)=1; C(1,1)=-1;     
C(2,12)=1; C(2,1)=-1;    
C(3,12)=1; C(3,2)=-1;                                              
C(4,13)=1; C(4,2)=-1;
C(5,13)=1; C(5,3)=-1;
C(6,14)=1; C(6,3)=-1;
C(7,14)=1; C(7,4)=-1;
C(8,15)=1; C(8,4)=-1;
C(9,1)=1;  C(9,5)=-1;
C(10,2)=1; C(10,5)=-1; 
C(11,2)=1; C(11,6)=-1; 
C(12,3)=1; C(12,6)=-1; 
C(13,3)=1; C(13,7)=-1; 
C(14,4)=1; C(14,7)=-1; 
C(15,5)=1; C(15,8)=-1; 
C(16,6)=1; C(16,8)=-1; 
C(17,6)=1; C(17,9)=-1; 
C(18,7)=1; C(18,9)=-1; 
C(19,8)=1; C(19,10)=-1; 
C(20,9)=1; C(20,10)=-1; 

% Vertical load in the extreme (point 10)
U = zeros(dim,q);
U(1,10) = 0;
U(2,10) = -10;

% Static state ------------------------------------------------------------
[c_bars,t_strings,V] = tensegrity_statics(b,s,q,p,dim,Q,P,C,U);
tensegrity_plot(Q,P,C,b,s,U,V,true,2.0);


%%  DIRECT STIFFNESS METHOD

% Construction of Ns Cs Us R A E (see ST.m) -------------------------------

% Nodal coordinates
Ns=[N' zeros(n,1)];

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
R(:,3)=1;
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