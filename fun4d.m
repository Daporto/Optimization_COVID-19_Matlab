function J = fun4d(Yo,pa,tobs,x0,x0b,B0,R)
    [~,Yk] = ode45(@(t,y)model(t,y,pa),tobs,x0);
    dx0 = x0b-x0;
    Jb = dx0'*(pinv(B0)*dx0);
    Jo = (1/R)*norm(Yo-Yk)^2;
    J = Jb+Jo;
end