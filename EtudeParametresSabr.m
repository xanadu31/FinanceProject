function y=EtudeParametresSabr()
S=100;
r=0.03;
q=0;
T=1;
nblig=10;
nbcol=4;
%On fait varier les parametres
alpha=(0.2:0.2:1);
beta=(0.2:0.2:1);
rho=(-0.8:0.2:0);
v0=(0.1:0.1:0.4);
y=(80:5:(5*nblig-1)+80);
MatAlpha=zeros(nblig,nbcol)
MatBeta=zeros(nblig,nbcol)
MatRho=zeros(nblig,nbcol)
MatV0=zeros(nblig,nbcol)

for i= 1:nblig
    for j=1:nbcol
        %On calcule les vol en faisant varier chaque parametre sur des
        %strikes allant de 5 en 5 de 80 à 120
        MatAlpha(i,j)=volSabr(S,y(i),T,alpha(j),1,-0.5,0.2);
        MatBeta(i,j)=volSabr(S,y(i),T,1,beta(j),-0.5,0.2);
        MatRho(i,j)=volSabr(S,y(i),T,1,1,rho(j),0.2);
        MatV0(i,j)=volSabr(S,y(i),T,1,1,-0.5,v0(j));
    end
end

% On ouvre une figure par parametre
plot(y,MatAlpha(:,1))
hold all
plot(y,MatAlpha(:,2))
hold all
plot(y,MatAlpha(:,3))
hold all
plot(y,MatAlpha(:,4))
figure
plot(y,MatBeta(:,1))
hold all
plot(y,MatBeta(:,2))
hold all
plot(y,MatBeta(:,3))
hold all
plot(y,MatBeta(:,4))
figure
plot(y,MatRho(:,1))
hold all
plot(y,MatRho(:,2))
hold all
plot(y,MatRho(:,3))
hold all
plot(y,MatRho(:,4))
figure
plot(y,MatV0(:,1))
hold all
plot(y,MatV0(:,2))
hold all
plot(y,MatV0(:,3))
hold all
plot(y,MatV0(:,4))
end