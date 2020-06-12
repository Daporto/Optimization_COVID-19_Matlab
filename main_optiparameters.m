clc;
clear all;
close all;

S0 = 47000000;
b = 0.37;
g = 1/14;
I0 = 1;
R0 = 0;
y0 = [S0;I0;R0];
pr = [b;g];
ndias=20; %nùmero de días de las observaciones
ndiasm=20; %nùmero de dias de la proyección
tobs = 1:1:ndiasm; 

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
 b
%Data set 2
Iacum = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'C2:C92');
Rec = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'E2:E92');
Death = xlsread('DataSets\Data2\Colombia_COVID19_Coronavirus_casos_diarios1',1,'D2:D92');
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

h = 0.01;
niter = 150;
pak = pr;
    for k = 1:niter
        disp(k);
        PK(:,k)=pak;
        gk= fun_dev(Yobs, pak, tobs, y0, h);
        Hk= fun_dev2(Yobs, pak, tobs, y0, h);
        %dk= -gk/norm(gk);
        dk = -Hk\gk;
        eta = line_search(0, 1, 10,Yobs, pak, dk, tobs, y0);
        pak = pak+eta*dk;
        DK(:,k)= dk;
    end

[T,Y] = ode45(@(t,y)model(t,y,pak),tobs,y0);

figure;
hold on
plot(Yobs(:,1),'b');
plot(Y(:,1),'-.r');
legend({'Observations','model estimate'})
xlabel('Day');
ylabel('Susceptibles');
% legend({'susceptibles','Infectiouses','Recovered'})
title('Susceptibles')
grid on;
hold off

figure;
hold on
plot(Yobs(:,2),'b');
plot(Y(:,2),'-.r');
legend({'Observations','model estimate'})
xlabel('Day');
ylabel('Infected');
title('Infected')
grid on;
hold off

figure;
hold on
plot(Yobs(:,3),'b');
plot(Y(:,3),'-.r');
legend({'Observations','model estimate'})
xlabel('Day');
ylabel('Recovered or Deaths');
title('Recovered or Deaths')
grid on;
hold off

taml=17;
figure;
hold on
plot(PK(1,:),PK(2,:),'-ro','markerfacecolor','r');
plot(PK(1,1),PK(2,1),'-go','markerfacecolor','g');
set(gca,'FontSize',14);
title('Newton method iterations (Parameters)','FontSize',taml);
legend({'Newton Method iteration','Initial Point'},'FontSize',taml);
xlabel('{\beta} (Transmission rate)','FontSize',taml);
ylabel('{\gamma} (Recovery rate)','FontSize',taml);
grid on;
hold off
