clear all
close all
clc

load('data\apc9x47\apc9x47_exp_data.mat')
load('data\apc9x47\apc9x47_th_himera2.mat')


%static
figure()
plot(apc9x47sf_static.RPM,apc9x47sf_static.CT,'b*');
title('Static');
xlabel('RPM');
ylabel('CT');
grid on;
grid minor;
hold on;
plot(apc9x47sf_static_th.RPM,apc9x47sf_static_th.CT,'r*');
hold off;

figure()
plot(apc9x47sf_static.RPM,apc9x47sf_static.CP,'b*');
title('Static');
xlabel('RPM');
ylabel('CP');
grid on;
grid minor;
hold on;
plot(apc9x47sf_static_th.RPM,apc9x47sf_static_th.CP,'r*');
hold off;

%4008
figure()
plot(apc9x47sf_4008.J,apc9x47sf_4008.CT,'*');
title('4008 RPM, CT');
xlabel('J');
ylabel('CT')
grid on;
grid minor;
hold on
plot(apc9x47sf_4008_th.J,apc9x47sf_4008_th.CT,'*r');
hold off

figure()
plot(apc9x47sf_4008.J,apc9x47sf_4008.CP,'*');
title('4008 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_4008_th.J,apc9x47sf_4008_th.CP,'*');
hold off

%5013
figure()
plot(apc9x47sf_5013.J,apc9x47sf_5013.CT,'*');
title('5013 RPM, CT');
xlabel('J');
ylabel('CT')
grid on;
grid minor;
hold on
plot(apc9x47sf_5013_th.J,apc9x47sf_5013_th.CT,'*');
hold off

figure()
plot(apc9x47sf_5013.J,apc9x47sf_5013.CP,'*');
title('5013 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_5013_th.J,apc9x47sf_5013_th.CP,'*');
hold off

%6004
figure()
plot(apc9x47sf_6004.J,apc9x47sf_6004.CT,'*');
title('6004 RPM, CT');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_6004_th.J,apc9x47sf_6004_th.CT,'*');
hold off

figure()
plot(apc9x47sf_6004.J,apc9x47sf_6004.CP,'*');
title('6004 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_6004_th.J,apc9x47sf_6004_th.CP,'*');
hold off


%6029
figure()
plot(apc9x47sf_6029.J,apc9x47sf_6029.CT,'*');
title('6029 RPM, CT');
xlabel('J');
ylabel('CT')
grid on;
grid minor;
hold on
plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CT,'*');
hold off

figure()
plot(apc9x47sf_6029.J,apc9x47sf_6029.CP,'*');
title('6029 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CP,'*');
hold off

%6815
figure()
plot(apc9x47sf_6815.J,apc9x47sf_6815.CT,'*');
title('6815 RPM, CT');
xlabel('J');
ylabel('CT')
grid on;
grid minor;
hold on
plot(apc9x47sf_6815_th.J,apc9x47sf_6815_th.CT,'*');
hold off

figure()
plot(apc9x47sf_6815.J,apc9x47sf_6815.CP,'*');
title('6815 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_6815_th.J,apc9x47sf_6815_th.CP,'*');
hold off

%6819
figure()
plot(apc9x47sf_6819.J,apc9x47sf_6819.CT,'*');
title('6819 RPM, CT');
xlabel('J');
ylabel('CT')
grid on;
grid minor;
hold on
plot(apc9x47sf_6819_th.J,apc9x47sf_6819_th.CT,'*');
hold off

figure()
plot(apc9x47sf_6819.J,apc9x47sf_6819.CP,'*');
title('6819 RPM, CP');
xlabel('J');
ylabel('CP')
grid on;
grid minor;
hold on
plot(apc9x47sf_6819_th.J,apc9x47sf_6819_th.CP,'*');
hold off


