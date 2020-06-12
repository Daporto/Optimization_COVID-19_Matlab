clc;
clear all;
close all;

ndias=20; %numero de días
t = 1:1:ndias;
N = 1000; %número de condiciones iniciales agenerar
A = [];
xc = [];
pak = [0.3401;0.0094]'; % parametros
tobs = 1:1:15; %numero de días para hacer la projeccion en el modelo de los números random generados
for i=1:N
    xr = abs(randn(2,1));
    xr = [randi([47500000,48500000],1);xr];
    XR(i,:)=xr';
    A = [A;xr'];
    [T,Y] = ode45(@(t,y)model(t,y,pak),tobs,xr);
    xc = [xc;Y(end,:)];
end

%Data set 1
% Iacum = xlsread('DataSets\Data1\Countries-Confirmed',1,'AT49:BT49');
% Rec = xlsread('DataSets\Data1\Countries-Recovered',1,'AT49:BT49');
% Death = xlsread('DataSets\Data1\Countries-Deaths',1,'AT49:BT49');
% Iactivos = Iacum-Rec-Death;
% Iactivos = Iactivos(:,1:ndias);
% Suscep = S0-Iacum;
% Suscep = Suscep(:,1:ndias);
% Rec = Rec(:,1:ndias);
% Rec = Rec + Death(:,1:ndias);
% Yobs = [Suscep;Iactivos;Rec];
% Yobs = transpose(Yobs);

%Data set 2
S0=48000000;
Iacum = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'C2:C21');
Rec = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'E2:E21');
Death = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'D2:D21');
Iactivos = Iacum-Rec-Death;
Iactivos = Iactivos(1:ndias,:);
Iactivos = Iactivos';
Suscep = S0-Iacum;
Suscep = Suscep(1:ndias,:);
Suscep = Suscep';
Rec = Rec(1:ndias,:);
Rec = Rec + Death(1:ndias,:);
Rec = Rec';
Yobs = [Suscep;Iactivos;Rec];
Yobs = transpose(Yobs);

B0 = cov(xc);
R = 0.01;
h = 0.1;
x0b = mean(xc)';
xk = x0b;

niter=120;

%Metodo de Newton
for k=1:niter
    k
    XK(k,:) = xk';
    Hk = fun4d_H(Yobs,pak,t,xk,x0b,B0,R,h);
    gk = fun4d_g(Yobs,pak,t,xk,x0b,B0,R,h);
    dxk = -Hk\gk;
    DXK(k,:)=dxk;
    alp=line_searchv(0,1,dxk,Yobs,pak,t,xk,x0b,B0,R,10);
    xk = xk +alp*dxk; %valor de las condiciones iniciales en cada iteración
end
taml=17;
figure;
title('Iterations Newton Method','FontSize',taml);
set(gca,'FontSize',14);
hold all
plot3(xc(:,1),xc(:,2),xc(:,3),'oy','markersize',4,'markerfacecolor','g');
plot3(XK(:,1),XK(:,2),XK(:,3),'-or','markersize',8,'markerfacecolor','r');
plot3(x0b(1),x0b(2),x0b(3),'ob','markersize',12,'markerfacecolor','b');
legend({'Initial condition','Newton method iteration','Average of initial conditions'},'FontSize',taml)
xlabel('Susceptibles','FontSize',taml);
ylabel('Infected','FontSize',taml);
zlabel('Recovered','FontSize',taml);
%plot3(xc(:,2),xc(:,3),J,'ob','markersize',8,'markerfacecolor','b');
grid on;
