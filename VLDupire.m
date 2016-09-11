function VLDupire=VLDupire(y,M,t)

S=1961;
r=0.03;
q=0;
%Lis le csv contenant les prix d'options et trace les surfaces de
%volatilité implicite Black Scholes avec les prix du marché et les prix
MarketPrice = csvread('sp500.csv');


S=1961;
r=0.03;
q=0;


[nblig, nbcol] = size(MarketPrice);


M=zeros(nblig, nbcol); % matrice des prix de l'option
IV=zeros(nblig, nbcol); %matrice de vol implicite
y=(1890:5:(nblig-1)*5+1890);
K=y;
t=(1/12:1/12:(nbcol)*1/12);


% Theta method variables.
Theta_variable = 0.5;         % 0 <= Theta <= 1
K = y;
C = M;
T = t;
NK = size(K,2);  %nombre de strike
NT = size(T,2); %nombre de maturite

% Theta method variables in our workspace 
Theta = Theta_variable;

%% calcul
% delta T
for i=1:NT-1
    delta_T(i)=T(i+1)-T(i);
end
% Delta K
for j=1:NK-1
    delta_K(j)=K(j+1)-K(j);
end
% Derviee partiel call par rapport a la maturite
for i=1:NT-1
    for j=1:NK
        if C(i+1,j)==0  
            dp_C_r_T(i,j)=0;
        else
            dp_C_r_T(i,j)=(C(i+1,j)-C(i,j))/delta_T(i);
            dp_C_r_T(i+1,j)=0;
        end
    end
end
% Derviee partiel call par rapport au strike
for i=1:NT-1
    for j=2:NK-1   
        if C(i,j-1)==0 || C(i,j+1)==0 || C(i+1,j-1)==0 || C(i+1,j+1)==0
            dp_C_r_K(i,j)=0; 
        else   
            dp_C_r_K(i,j)=Theta*(-C(i,j-1)+C(i,j+1))+(1-Theta)*(-C(i+1,j-1)+C(i+1,j+1))/(2*delta_K(i)); 
        end
        dp_C_r_K(i+1,j)=0;
        dp_C_r_K(i,j+1)=0;
    end
end
% Derviee partiel seconde call par rapport au strike
for i=1:NT-1
    for j=2:NK-1 
        if C(i,j)==0 || C(i,j-1)==0 || C(i,j+1)==0 || C(i+1,j)==0 || C(i+1,j-1)==0 || C(i+1,j+1)==0        
            sec_dp_C_r_K(i,j)=0; 
        else
            sec_dp_C_r_K(i,j)=Theta*(C(i,j-1)-2*C(i,j)+C(i,j+1))+(1-Theta)*(C(i+1,j-1)-2*C(i+1,j)+C(i+1,j+1))/(delta_K(i)*delta_K(i));
        end
        sec_dp_C_r_K(i+1,j)=0;
        sec_dp_C_r_K(i,j+1)=0;
    end
end

%utilisation formule vol loc dupire
for i=1:NT-1
    for j=2:NK-1
        if sec_dp_C_r_K(i,j)==0 || dp_C_r_T(i,j)==0 || dp_C_r_K(i,j)==0  
            Loc_vol1(i,j)=0;
        else
        Loc_vol1(i,j)=sqrt(2*dp_C_r_T(i,j)/K(1,j)*K(1,j)*sec_dp_C_r_K(i,j));
        end
        Loc_vol1(i,j+1)=0;
        Loc_vol1(i+1,j)=0;
    end
end
VLDupire=Loc_vol1;
end




