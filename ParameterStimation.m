clc;
clear all;
close all;

%b = 0.35;
%g = 1/12;
% S0 = 1000000;
% b = 0.35;
% g = 1/12;
% I0 = 1;
% R0 = 0;
% y0 = [S0;I0;R0];
% pr = [b;g];
ndias=20; %max 43
t = 1:1:ndias;
N = 1000;
A = [];
xc = [];
pak = [0.3431;0.0094];
tobs = 1:1:10;
for i=1:N
    xr = abs(randn(2,1));
    %xr = [randi(49000000,1);xr];
    xr = [48000000;xr];
    A = [A;xr'];
    [T,Y] = ode45(@(t,y)model(t,y,pak),tobs,xr);
    xc = [xc;Y(end,:)];
end

figure;
hold on
plot3(A(:,1),A(:,2),A(:,3),'b');
hold off
title('sin sentido');
xlabel('Susceptibles');
ylabel('Infected');
zlabel('Recovered or Death');

figure;
hold on
plot3(xc(:,1),xc(:,2),xc(:,3),'b');
hold off
title('con sentido');
xlabel('Susceptibles');
ylabel('Infected');
zlabel('Recovered or Death');

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
h = 1;
x0b = mean(xc)';
for e=1:N
    e
    x0 = xc(e,:)';
    %G(e) = norm(fun4d_g(Yobs,pak,t,x0,x0b,B0,R,h));
    J(e) = fun4d(Yobs,pak,t,x0,x0b,B0,R);   
end

% h = 0.01;
% niter = 100;
% %thetaop = Newton(Yobs, pr, tobs, y0, h, niter);
% pak = pr;
%     for k = 1:niter
%         disp(k);
%         PK(:,k)=pak;
%         gk= fun_dev(Yobs, pak, tobs, y0, h);
%         Hk= fun_dev2(Yobs, pak, tobs, y0, h);
%         dk= -gk/norm(gk);
%         dk = -Hk\gk;
%         eta = line_search(0, 1, 10,Yobs, pak, dk, tobs, y0);
%         pak = pak+eta*dk;
%         DK(:,k)= dk;
%     end
% 
% [T,Y] = ode45(@(t,y)model(t,y,pak),tobs,y0);
% 
% figure;
% hold on
% plot(Yobs(:,1),'b');
% plot(Y(:,1),'-.r');
% legend({'Observations','model estimate'})
% xlabel('Day');
% ylabel('Susceptibles');
% % legend({'susceptibles','Infectiouses','Recovered'})
% title('Susceptibles')
% grid on;
% hold off
% 
% figure;
% hold on
% plot(Yobs(:,2),'b');
% plot(Y(:,2),'-.r');
% legend({'Observations','model estimate'})
% xlabel('Day');
% ylabel('Infected');
% title('Infected')
% grid on;
% hold off
% 
% figure;
% hold on
% plot(Yobs(:,3),'b');
% plot(Y(:,3),'-.r');
% legend({'Observations','model estimate'})
% xlabel('Day');
% ylabel('Recovered or Death');
% title('Recovered or Death')
% grid on;
% hold off
% 
% figure;
% hold on
% plot(PK(1,:),PK(2,:),'-bo','markerfacecolor','b');
% title('Parameters')
% grid on;
% hold off
% figure;
% hold on
% plot(Yobs(:,1),'b');
% plot(Yobs(:,2),'r');
% plot(Yobs(:,3),'g');
% legend({'susceptibles','Infectiouses','Recovered'})
% title('Observaciones')
% grid on;
% hold off