function [C,Ceq] = fonction_contrainte_non_lineaire(x)

%matrice des coefficients pour le calcul des enthalpies massiques
M =[-6.8909 -14.8538 -28.2807 -11.4172 ;
    0.0991 0.1333 0.1385 0.1229 ;
    1.1081*10^(-4) 0.7539*10^(-4) 0.9043*10^(-4) 0.7940*10^(-4)];

%calcul enthalpie 
h= @(t,n) M(1,n)+ M(2,n)*t +M(3,n)*t^2;

%matrice des enthalpies calculées
E=[h(x(16),1)*x(1) h(x(17),1)*x(2) h(x(18),1)*x(3) h(x(19),1)*x(4) h(x(20),1)*x(5) h(x(21),1)*x(6) h(x(22),1)*x(7) h(x(23),1)*x(8) h(x(24),2)*x(9) h(x(25),2)*x(10) h(x(26),2)*x(11) h(x(27),3)*x(12) h(x(28),3)*x(13) h(x(29),4)*x(14) h(x(30),4)*x(1,15)];

%équations
Ceq =[abs((E(2)-E(1)))-abs((E(11)-E(10)));
    abs((E(4)-E(3)))-abs((E(10)-E(9)));
    abs((E(5)-E(4)))-abs((E(13)-E(12)));
    abs((E(7)-E(6)))-abs((E(15)-E(14)));
    abs(E(2))-abs((E(3)+E(6)));
    abs(E(5))+abs((E(7)-E(8))];
C=[];
return 








