function etaopt = line_search(a,b,M,Yo,pa,dpa,tobs,y0)
for k=1:M
    del = (b-a)/4;
    eta1 = a+1*del;
    eta2 = a+2*del;
    eta3 = a+3*del;
    pa1 = pa + eta1*dpa;
    pa2 = pa + eta2*dpa;
    pa3 = pa + eta3*dpa;
    f1 = fun(Yo, pa1,tobs,y0);
    f2 = fun(Yo, pa2,tobs,y0);
    f3 = fun(Yo, pa3,tobs,y0);
    if f1<=f2 && f1<= f3
        b= eta2;
    else
        if f2<= f3 && f2<= f1
            a= eta1;
            b= eta3;
        else
            a= eta2;
        end
    end
end       
etaopt = (a+b)/2;
end
