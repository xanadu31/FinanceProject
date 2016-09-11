function vol=volSabr(S,K,T,alpha,beta,rho,v)


x = log(S./ K);
u = (alpha .* x) ./ v;
z = (alpha./v)  .* ((S.^(1 - beta) - K.^(1 - beta)) ./ (1 - beta));
i0 = 0;
if (x == 0)
    i0 = v .* (K.^(beta-1));
elseif (alpha == 0)
    i0 = (x .* v .* (1 - beta)) ./ (S.^(1 - beta) - K.^(1 - beta));
elseif (beta == 1)
    i0 = (alpha .* x) ./ (log((sqrt(1 - 2 .* rho .* u + u .* u) + u - rho) ./ (1 - rho)));
elseif (beta <= 1)
    i0 = (alpha .* x) ./ (log((sqrt(1 - 2 .* rho .* z + z .* z) + z - rho) ./ (1 - rho)));
end

i1 = (((beta - 1).^ 2) ./ 24) .* (v .* v ./ ((S .* K).^( 1 - beta))) + 0.25 .* (rho .* alpha .* beta .* v) ./ (S .* K).^((1 - beta) ./ 2) + (2 - 3 .* rho .* rho) .* alpha .* alpha ./ 24;

vol = i0 .* (1 + i1 .* T);
end