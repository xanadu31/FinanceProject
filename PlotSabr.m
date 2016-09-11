function y=PlotSabr(params,MarketIV)

[nblig, nbcol] = size(MarketIV);

M=zeros(nblig, nbcol); % matrice des prix de l'option
IV=zeros(nblig, nbcol); %matrice de vol implicite
y=(80:10:(10*nblig-1)+80);
t=(1:1:nbcol);

for lig=1:1:nblig    
    for col=1:1:nbcol % on parcours les colonnes pour une ligne i fixée (i.e pour un Strike K fixé)        
        M= MarketIV;
        IV(lig,col) =volSabr(100,y(lig),t(col),params(1),params(2),params(3),params(4));    
        
    end    
end
C=M-IV

figure
mesh(t,y,IV)
hold on
mesh(t,y,M)
ax=axis;
axis([ax(1) ax(2) 80 120 ax(5) ax(6)])
figure
bar3(C.^2);
hold on

end