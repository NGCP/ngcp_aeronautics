close all

%% Import(run with corresponding props object open)
r1050 = linspace(10*0.2,10)*0.0254/2;
r1147 = linspace(11*0.2,11)*0.0254/2;
r947  = linspace(9.47*0.2,11)*0.0254/2;

tht1050 = apc1050.geom.tht(r1050);
tht1147 = apc1147.geom.tht(r1147);
tht947  = apc947.geom.tht(r947);

%% Vis
figure()
plot(r1050,tht1050*180/pi);
xlabel('r,m');
ylabel('tht,deg');
grid on
grid minor
hold on
plot(r1050,atand(5*0.0254./(2*pi*r1050)));
hold off

figure()
plot(r1147,tht1147*180/pi);
xlabel('r,m');
ylabel('tht,deg');
grid on
grid minor
hold on
plot(r1147,atand(4.7*0.0254./(2*pi*r1147)));
hold off

figure()
plot(r947,tht947*180/pi);
xlabel('r,m');
ylabel('tht,deg');
grid on
grid minor
hold on
plot(r947,atand(4.7*0.0254./(2*pi*r947)));
hold off

