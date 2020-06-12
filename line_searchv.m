function alpopt = line_searchv(a,b,dxk,Yo,pa,tobs,x0,x0b,B0,R,M)
for k=1:M
    dalp = (b-a)/4;
    alp1 = a+1*dalp;
    alp2 = a+2*dalp;
    alp3 = a+3*dalp;
    x1 = x0 + alp1*dxk;
    x2 = x0 + alp2*dxk;
    x3 = x0 + alp3*dxk;
    J1 = fun4d(Yo,pa,tobs,x1,x0b,B0,R);
    J2 = fun4d(Yo,pa,tobs,x2,x0b,B0,R);
    J3 = fun4d(Yo,pa,tobs,x3,x0b,B0,R);
    if J1<=J2 && J1<= J3
        b= alp2;
    else
        if J2<= J3 && J2<= J1
            a= alp1;
            b= alp3;
        else
            a= alp2;
        end
    end
end       
alpopt = (a+b)/2;
end