%Zachary Vogel and MO WOOODSIIIIIII !!!!!
%doin work
%document created on 4/20/2016 #blazeit

M=0.05;
m=0.05;
g=-9.8;
l=0.05;
r=0.05;



A=[0 1 0 0;(M+m)*g/(M*l) 0 0 0;0 0 0 1; -m*g/(M*r) 0 0 0];
B=[0;1/(r*M*l);0;1/(r^2*M)];
C=[1 0 0 0];
D=0;

sys=ss(A,B,C,D);

damp(sys)
rlocus(sys)