function g = fun4d_g(Yo,pa,tobs,x0,x0b,B0,R,h)
    [nvar,~] = size(x0);
    e = eye(nvar,nvar);
    g = zeros(nvar,1);
    for i = 1:nvar
        ei = e(:,i);
        x1 = x0 +ei*h;
        x2 = x0 -ei*h;
        J1 = fun4d(Yo,pa,tobs,x1,x0b,B0,R);
        J2 = fun4d(Yo,pa,tobs,x2,x0b,B0,R);
        g(i) = (J1-J2)/(2*h);
    end
end