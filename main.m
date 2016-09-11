%%Partie 1: Black Scholes
S=1925;
r=0.02;
q=0;
%Lis le csv contenant les prix d'options et trace les surfaces de
%volatilité implicite Black Scholes avec les prix du marché et les prix
%obtenus avec SABR
MarketPrice = csvread('sp500-2.csv');
Plot(S,r,q,MarketPrice);


%%Partie 2 : SABR et calibration

%Choisir un des deux MarketIV pour lancer la calibration sur les données
%synthétiques ou la calibration sur les données du marché

%MarketIV=csvread('BNP.csv');
MarketIV=CalibrationSynth(100,0.03,0)

%Calibration en utilisant lsqnonlin
TC = @(z)ToCalibrate(z(1),z(2),z(3),z(4),MarketIV);
x0 = [.5 .5 0 .2];
lb = [0 0 -1 0];
ub = [1 1 1 1 ];
params= lsqnonlin(TC,x0,lb,ub);

%parametres obtenus après calibration
alpha = params(1);
beta = params(2);
rho = params(3);
v = params(4);
params

%On trace les surfaces d'origine et les surfaces obtenus après calibration
PlotSabr(params,MarketIV)

%Etude de l'influence des parametres sur la courbe de volatilité implicite
EtudeParametresSabr()

%%Partie 3 : Dupire






