function Hf = fun_dev2(Yo,pa,tobs,y0,h)
    np = length(pa);
    e = eye(np,np);
    Hf = zeros(np,np);
    for i = 1:np
        for j = 1:np
            thetat = pa+e(:,j)*h;
            thetag = pa-e(:,j)*h;
            fftt = fun(Yo,thetat+e(:,i)*h,tobs,y0); %f(thetat+h)
            fbtt = fun(Yo,thetat-e(:,i)*h,tobs,y0); %f(thetat-h)
            fftg = fun(Yo,thetag+e(:,i)*h,tobs,y0); %f(thetag+h)
            fbtg = fun(Yo,thetag-e(:,i)*h,tobs,y0); %f(thetag-h)
            Hf(i,j) = (fftt-fbtt-fftg+fbtg)/((4*h)^2); %(f(thetat+h)-f(thetat-h)-f(thetag+h)+f(thetag-h))/(4*h^2)
        end
    end
end