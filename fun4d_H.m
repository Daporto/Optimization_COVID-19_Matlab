function H = fun4d_H(Yo,pa,tobs,x0,x0b,B0,R,h)
    [nvar,~] = size(x0);
    e = eye(nvar,nvar);
    H = zeros(nvar,nvar);
    for i = 1:nvar
        for j = 1:nvar
            ei = e(:,i);
            ej = e(:,j);    
            x0t = x0 + ej*h;
            x0g = x0 - ej*h;        
            x1 = x0t + ei*h; J1 = fun4d(Yo,pa,tobs,x1,x0b,B0,R);
            x2 = x0t - ei*h; J2 = fun4d(Yo,pa,tobs,x2,x0b,B0,R);
            x3 = x0g + ei*h; J3 = fun4d(Yo,pa,tobs,x3,x0b,B0,R);
            x4 = x0g - ei*h; J4 = fun4d(Yo,pa,tobs,x4,x0b,B0,R); 
            H(i,j) = (1/(4*(h^2)))*(J1-J2-J3+J4);
        end
    end
end