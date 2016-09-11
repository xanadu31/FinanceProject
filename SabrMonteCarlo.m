function mccallprice=SabrMonteCarlo(S0,K,T,alpha,beta,rho,v0,NSim,NTime)
dt = T/NTime;
r=0.03;
q=0;


pathS = zeros(NSim,NTime+1);
pathV = pathS;

S = zeros(NSim,NTime+1);
V = zeros(NSim,NTime+1);
S(:,1) = S0;
V(:,1) = alpha;

NullVec = zeros(NSim,1);

N1 = randn(NSim,NTime);
N2 = randn(NSim,NTime);
N2 = rho * N1 + sqrt(1-rho^2) * N2;
    for k = 2:NTime+1
        dW1 = sqrt(dt)* N1(:,k-1);
        dW2 = sqrt(dt)* N2(:,k-1);
        S(:,k) = S(:,k-1) + (r-q) * dt + V(:,k-1).*max([S(:,k-1),NullVec],[],2).^beta.*dW1;
        V(:,k) = V(:,k-1) + v0*V(:,k-1).*dW2;
    end
    pathS(:,:) = S;
    pathV(:,:) = V;
    Sfinal=pathS(:,end)

payoff=max(Sfinal-K,0);
mccallprice=exp(-r*T)*mean(payoff);
end