function df = fun_dev(Yo,pa,tobs,y0,h)
    np = length(pa);
    e = eye(np,np);
    df = zeros(np,1);
    for i=1:np
        ff = fun(Yo,pa+e(:,i)*h,tobs,y0); %f(theta+ei*h)
        fb = fun(Yo,pa-e(:,i)*h,tobs,y0); %f(theta-ei*h)
        df(i) =  (ff-fb)/(2*h); %(f(theta+ei*h)-f(theta-ei*h))/2h
    end
end