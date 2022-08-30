clear all
close all
clc

load('data\apc9x47\apc9x47_exp_data.mat')
load('data\apc9x47\apc9x47_th_himera2.mat')


%static
figure()
subplot(2,1,1)
plot(apc9x47sf_static.RPM,(apc9x47sf_static_th.CT-apc9x47sf_static.CT)./apc9x47sf_static.CT*100,'b*');
title('Static');
xlabel('RPM');
ylabel('Percent error in CT');
grid on;
grid minor;

subplot(2,1,2)
plot(apc9x47sf_static.RPM,(apc9x47sf_static_th.CP - apc9x47sf_static.CP)./apc9x47sf_static.CP*100,'b*');
title('Static');
xlabel('RPM');
ylabel('Percent error in CP');
grid on;
grid minor;

%4008
figure()
subplot(2,1,1)
plot(apc9x47sf_4008.J,(apc9x47sf_4008_th.CT - apc9x47sf_4008.CT)./apc9x47sf_4008.CT*100,'*');
title('4008 RPM, CT');
xlabel('J');
ylabel('Percent error in CT');
grid on;
grid minor;

subplot(2,1,2)
plot(apc9x47sf_4008.J,(apc9x47sf_4008_th.CP - apc9x47sf_4008.CP)./apc9x47sf_4008.CP*100,'*');
title('4008 RPM, CP');
xlabel('J');
ylabel('Percent error in CP');
grid on;
grid minor;

figure()
subplot(2,1,1)
plot(apc9x47sf_4008.J,(apc9x47sf_4008_th.CT - apc9x47sf_4008.CT)./apc9x47sf_4008.CT*100,'*');
title('4008 RPM, CT');
xlabel('J');
ylabel('Percent error in CT');
axis([0,0.6,-60,50])
grid on;
grid minor;

subplot(2,1,2)
plot(apc9x47sf_4008.J,(apc9x47sf_4008_th.CP - apc9x47sf_4008.CP)./apc9x47sf_4008.CP*100,'*');
title('4008 RPM, CP');
xlabel('J');
ylabel('Percent error in CP');
axis([0,0.6,-40,inf])
grid on;
grid minor;


% %5013
% figure()
% plot(apc9x47sf_5013.J,apc9x47sf_5013.CT,'*');
% title('5013 RPM, CT');
% xlabel('J');
% ylabel('CT')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_5013_th.J,apc9x47sf_5013_th.CT,'*');
% hold off
% 
% figure()
% plot(apc9x47sf_5013.J,apc9x47sf_5013.CP,'*');
% title('5013 RPM, CP');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_5013_th.J,apc9x47sf_5013_th.CP,'*');
% hold off
% 
% %6004
% figure()
% plot(apc9x47sf_6004.J,apc9x47sf_6004.CT,'*');
% title('6004 RPM, CT');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6004_th.J,apc9x47sf_6004_th.CT,'*');
% hold off
% 
% figure()
% plot(apc9x47sf_6004.J,apc9x47sf_6004.CP,'*');
% title('6004 RPM, CP');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6004_th.J,apc9x47sf_6004_th.CP,'*');
% hold off
% 
% 
% %6029
% figure()
% plot(apc9x47sf_6029.J,apc9x47sf_6029.CT,'*');
% title('6029 RPM, CT');
% xlabel('J');
% ylabel('CT')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CT,'*');
% hold off
% 
% figure()
% plot(apc9x47sf_6029.J,apc9x47sf_6029.CP,'*');
% title('6029 RPM, CP');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CP,'*');
% hold off
% 
% %6815
% figure()
% plot(apc9x47sf_6815.J,apc9x47sf_6815.CT,'*');
% title('6815 RPM, CT');
% xlabel('J');
% ylabel('CT')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6815_th.J,apc9x47sf_6815_th.CT,'*');
% hold off
% 
% figure()
% plot(apc9x47sf_6815.J,apc9x47sf_6815.CP,'*');
% title('6815 RPM, CP');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6815_th.J,apc9x47sf_6815_th.CP,'*');
% hold off
% 
% %6819
% figure()
% plot(apc9x47sf_6819.J,apc9x47sf_6819.CT,'*');
% title('6819 RPM, CT');
% xlabel('J');
% ylabel('CT')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6819_th.J,apc9x47sf_6819_th.CT,'*');
% hold off
% 
% figure()
% plot(apc9x47sf_6819.J,apc9x47sf_6819.CP,'*');
% title('6819 RPM, CP');
% xlabel('J');
% ylabel('CP')
% grid on;
% grid minor;
% hold on
% plot(apc9x47sf_6819_th.J,apc9x47sf_6819_th.CP,'*');
% hold off
% 
% 
