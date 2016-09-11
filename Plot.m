function y=Plot(S,r,q,MarketPrice)

[nblig, nbcol] = size(MarketPrice);

M=zeros(nblig, nbcol); % matrice des prix de l'option
IV=zeros(nblig, nbcol); %matrice de vol implicite
y=(1890:5:(nblig-1)*5+1890); 
t=(1/12:1/12:(nbcol)*1/12); 

for lig=1:1:nblig    
    for col=1:1:nbcol % on parcours les colonnes pour une ligne i fixée (i.e pour un Strike K fixé)        
        M= MarketPrice;
        IV(lig,col) =blsimpv(S,y(lig),r,t(col),M(lig,col)); 
    end
end

M
IV(3,1)=0.0851
IV(5,1)=0.0565
IV
figure
mesh(t,y,IV)
title('Surface De Volatilité Partie 1')
ylabel('Strike')
xlabel('Date(mois)')

end