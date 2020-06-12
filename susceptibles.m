function suscep = susceptibles(S0,infec)
[~,n] = size(infec);
suscep(1)=S0-infec(1);
for k=2:n
suscep(k)=suscep(k-1)-infec(k);
end
end