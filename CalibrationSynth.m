function y=CalibrationSynth(S,r,q)
lig=5
col=5
IVSabr=zeros(lig, col);%matrice de vol implicite Sabr
y=(80:10:10*(lig-1)+80);
t=(1:1:col);

for lig=1:1:lig    
    for col=1:1:col % on parcours les colonnes pour une ligne i fixée (i.e pour un Strike K fixé)        
        IVSabr(lig,col)=blsimpv(S,y(lig),r,t(col),SabrBS(S,y(lig),t(col),r,q,1,1,-0.5,0.2));
        
    end    
end
y=IVSabr;
end