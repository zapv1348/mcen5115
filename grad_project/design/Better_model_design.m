%Zachary Vogel
%Real design of Control

%actual known values
g=9.8;%m/s^2 gravity
Rm=2.79; %ohms terminal resistance
kt=0.017; %Nm/A torque constant
Lm=.0015; %milli Henries, motor inductance
Jm=1.62*10^(-6); %kgm^2 motor inertia

%values from paper, need to find these before actual implementation
b1=6.0*10^(-4);%damping 1
b2=5.52*10^(-4);%damping 2
m1=0.1682;%mass of first rod?
m2=0.065;%mass of second rod?
L1=0.0955;%length from motor shaft to center of mass of motor rod+inverted pendulum rod
l1=0.03478;%length from motor shaft to Center of mass of motor rod
L2=0.2983;%length of inverted pendulum rod
l2=0.05847;%length from plane of motor rod to center of mass of motor rod+inverrted pendulum

%Inertia tensors are a 3 element vector of torques in 3 rotational
%directions equal to a 3X3 matrix of inertias times a 3 element vector of
%angular accelerations.

I1z=0.0013; %Izz Inertia only one from 
I2x=5.34*10^(-4); %other inertias, measured in CAD
I2y=8.41*10^(-4);
I2z=3.10*10^(-4);
I2xz=-2.4*10^(-4);

den=(I2x*I1z-I2xz^2+I2x*I2z+I2x*L1^2*m2+I2x*l1^2*m1+I1z*l2^2*m2+I2z*l2^2*m2+2*I2xz*L1*l2*m2+l1^2*l2^2*m1*m2);

A11=0;
A12=-(g*l2*m2*(I2xz-L1*l2*m2))/den;
A13=-(b1*(m2*l2^2+I2x))/den;
A14=(b2*(I2xz-L1*l2*m2))/den;
A15=(kt*(m2*l2^2+I2x))/den;

A21=0;
A22=(g*l2*m2*(m2*L1^2+m1*l1^2+I1z*I2z))/den;
A23=(b1*(I2xz-L1*l2*m2))/den;
A24=-(b2*(m2*L1^2+m1*l1^2+I1z+I2z))/den;
A25=-(kt*(I2xz-L1*l2*m2))/den;

A31=0;
A32=0;
A33=-kt/Lm;
A34=0;
A35=-Rm/Lm;

B1=0;
B2=0;
B3=1/Lm;

A=[0 0 1 0 0;0 0 0 1 0;A11 A12 A13 A14 A15;A21 A22 A23 A24 A25;A31 A32 A33 A34 A35];
B=[0;0;B1;B2;B3];
C=[0 1 0 0 0;1 0 0 0 0];
D=[0;0];

sys=ss(A,B,C,D);
[Wn,zeta]=damp(sys);
rank(obsv(A,C));
wn=min(Wn(Wn>0));
Ts=wn/(40*pi);

sys=c2d(sys,Ts);
pzmap(sys)
K=place(sys.a,sys.b,[0.988 0.99 0.97 0.95 0.2])
L=place(sys.a',sys.c',[0.8 0.7+0.1i 0.7-0.1i 0.1 0.3])'
