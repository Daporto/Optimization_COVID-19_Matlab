function f = fun(Yo,pa,tobs,y0)
[~,Yk] = ode45(@(t,y)model(t,y,pa),tobs,y0);
f = norm(Yk-Yo)^2;
end