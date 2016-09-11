function callSabrBS=SabrBS(S,K,T,r,q,alpha,beta,rho,v)
    callSabrBS=callBS(S,K,r,volSabr(S,K,T,alpha,beta,rho,v),0,T,q);
end