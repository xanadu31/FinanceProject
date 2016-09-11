%%Partie 2: Formule de Dupire
%% données


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
t=(1/12:1/12:(nbcol)*1/12);



%% calcul vol loc dupire
volLocDupire=VLDupire(y,M ,t);

