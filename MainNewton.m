clc, clear all, close all

filename = 'Casos positivos.xlsx';
[num, txt, raw] = xlsread(filename, 1,"B1:C56");
pbo = raw;
Yo = cell2mat(pbo);
tobs = 0:1:55;
sigobs = 0.01;

 fig1 = figure;
 hold all
 plot(tobs,Yo(:,1),'ob','linewidth',2);
 xlim([0 60]);
 yl = ylabel('$Infections$');
 xl = xlabel('$t$');
 set(xl,'fontsize',18,'interpreter','latex');
 set(yl,'fontsize',18,'interpreter','latex');
 set(gca,'fontsize',18);
 title('Observations I','fontsize',18);
 grid on
 print(fig,'-dpng','ObservI.png');
 
 fig = figure;
 hold all
 plot(tobs,Yo(:,2),'ob','linewidth',2);
 xlim([0 60]);
 yl = ylabel('$Recovers$');
 xl = xlabel('$t$');
 set(xl,'fontsize',18,'interpreter','latex');
 set(yl,'fontsize',18,'interpreter','latex');
 set(gca,'fontsize',18);
 title('Observations R','fontsize',18);
 grid on
 print(fig,'-dpng','ObserR.png');

h=0.0001;
x0= [-1;1];
paK = [0.5;0.5;0.35];
for k = 1:10
    PK(:,k)=paK;
    gk= fun_dev(Yo, paK, tobs, x0, h);
    Hk= fun_dev2(Yo, paK, tobs, x0, h);
    dk= -gk/norm(gk);
    eta = line_search(0, 1, 100,Yo, paK, dk, tobs, x0);
    pak = pak+eta*dk;
    DK(:,k)= dk;
end