clear variables
clc
close all

%%DEFINITION DES CONSTANTES DU PROBLEME

%matrice des coefficients pour le calcul des enthalpies massiques
C =[-6.8909 -14.8538 -28.2807 -11.4172 ;
    0.0991 0.1333 0.1385 0.1229 ;
    1.1081*10^(-4) 0.7539*10^(-4) 0.9043*10^(-4) 0.7940*10^(-4)];

%écart-types
ecart_type_debit=2 ; % en%
ecart_type_temperature=0.75 ; % en°

%relevé des mesures (température en °C et débit en kg/h)
M=[1000.00 466.33 401.70 481.78 530.09 616.31 552.70 619.00 614.92 253.20 618.11 308.10 694.99 667.84 680.10 558.34];
%  A1_D    A1_T   A3_D   A3_T   A4_T   A5_T   A6_D    A7_T   A8_T   B1_D   B1_T   C1_D   C1_T   D1_T   D2_D   D2_T         


%on a 30 variables (pour chaque courant débit et température), et N=16 (pour chaque mesures données) 
%X=[A1, A2, A3, A4, A5, A6, A7, A8, B1, B2, B3, C1, C2, D1, D2]
    

%%FONCTION OBJECTIF
fObj= @(x) ((x(1)-M(1))^2)/ecart_type_debit^2+((x(16)-M(2))^2)/ecart_type_temperature^2+((x(3)-M(3))^2)/ecart_type_debit^2+((x(18)-M(4))^2)/ecart_type_temperature^2+((x(19)-M(5))^2)/ecart_type_temperature^2+((x(20)-M(6))^2)/ecart_type_temperature^2+((x(6)-M(7))^2)/ecart_type_debit^2+((x(22)-M(8))^2)/ecart_type_temperature^2+((x(23)-M(9))^2)/ecart_type_temperature^2+((x(9)-M(10))^2)/ecart_type_debit^2+((x(24)-M(11))^2)/ecart_type_temperature^2+ ((x(12)-M(12))^2)/ecart_type_debit^2+((x(27)-M(13))^2)/ecart_type_temperature^2+((x(29)-M(14))^2)/ecart_type_temperature^2+((x(15)-M(15))^2)/ecart_type_debit^2+((x(30)-M(16))^2)/ecart_type_temperature^2;

%%CONTRAINTES

%Bornes
LB=zeros(1,30);
UB=2000*ones(1,30);

%contrainte d'inégalité
A=[];
B=[];
%contrainte linéaire (somme_débit)
Aeq=[-1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 -1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 -1 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

Beq= zeros(1,10);

%contrainte non linéaire (voir fonction_contrainte_non_linéaire)

%%OPTIMISATION

%initialisation
x0=zeros(1,30);
x0(1:15)=532.63;
x0(16:30)=586.552;

%résolution
[x,f,flag,output]=fmincon(fObj,x0,A,B,Aeq,Beq,LB,UB,@fonction_contrainte_non_lineaire);



