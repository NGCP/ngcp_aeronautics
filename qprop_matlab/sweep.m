% Uses qprop to make a parametricc sweep as described in comparison plan:
%{ 
Input:
Program itself:
RPM range for static test
J range for dynamic test
RPM for J range
D prop
Propdata

Output: 2 structures with:
1) static output:
 RPM, CT0, CP0

2) Dynamic output
 J,CT,CP,etaInput:
Program itself:
RPM range for static test
J range for dynamic test
RPM for J range
D prop
Propdata

Output: 2 structures with:
1) static output:
 RPM, CT0, CP0

2) Dynamic output
 J,CT,CP,eta
%}

%% Cleanup
clear all
close all
clc

%% Importing experimantal and other th propeller data
expDataStatRaw = importdata('InputDataFiles/UIUC/apcsf_9x4.7_static_kt1032.txt');
expDataStat.RPM = expDataStatRaw.data(:,1);
expDataStat.Ct0 = expDataStatRaw.data(:,2);
expDataStat.Cp0 = expDataStatRaw.data(:,3);
expDataStat = struct2table(expDataStat);

expDataDynamicRaw = importdata('InputDataFiles/UIUC/apcsf_9x4.7_kt1035_6029.txt');
expDataDynamic.J = expDataDynamicRaw.data(:,1);
expDataDynamic.Ct = expDataDynamicRaw.data(:,2);
expDataDynamic.Cp = expDataDynamicRaw.data(:,3);
expDataDynamic = struct2table(expDataDynamic);

load("InputDataFiles\th_data\apc9x47sf_6029_th.mat")
load("InputDataFiles\th_data\apc9x47sf_static_th.mat")
%% Setup
%prop
%motorfile for qprop
%propfile for qprop
%diameter in SI
motorfile  = 'wundermotor'; % 100 efficient motor: with very smalll resistance.
propfile   = 'apc9x47sf';
outputfile = 'lastrunOut';
D          = 9*2.54*10^(-2);

%envy
rho = 1.225; %density
mu  = 1.78E-5; %dynamic viscosity
c   = 340; %speed of sound
qcon=[rho mu c]; % [Density, Viscoity, Speed of Sound}
fileID = fopen('qcon.def','w');
fprintf(fileID,'%d \n' ,qcon);
fclose(fileID);
clear fileID qcon

%Sweep params
%RPM range for static run
%Advance ratio range for static run
%RPM for dynamic run
RPMrange    = linspace(1500,7500,100);
Jrange      = linspace(0.08,0.68,100);
RPMd        = 6029; 

%Making V range from J range
Vrange     = Jrange*D*(RPMd/60); % J = V/(nD), n - rotations per second

%% Running qprop
% Static run
% setup
Setpoint.Velocity = [0];
Setpoint.RPM      = [];
Setpoint.Voltage  = [];
Setpoint.dBeta    = 0.0;    % Leave as 0.0
Setpoint.Thrust   = [];
Setpoint.Torque   = [];
Setpoint.Current  = [];
Setpoint.Pele     = [];     % Leave Empty
for i = 1:length(RPMrange)
    Setpoint.RPM  = RPMrange(i);
    OutputStatRaw(i) = run_qprop(propfile,motorfile,outputfile,Setpoint);
end
% Interpreting results
for i = 1:length(OutputStatRaw)
    RPM = OutputStatRaw(i).RPMs;
    OutputStat(i).RPM = RPM;
    OutputStat(i).Ct0 = OutputStatRaw(i).Thrust/(rho*(RPM/60)^2*D^4);
    OutputStat(i).Cp0 = 2*pi*OutputStatRaw(i).Torque/(rho*(RPM/60)^2*D^5);
end

% Dynamic run
for i = 1:length(Vrange)
    Setpoint.RPM = RPMd;
    Setpoint.Velocity = Vrange(i);
    OutputDynamicRaw(i) = run_qprop(propfile,motorfile,outputfile,Setpoint);
end
% Interpreting results
for i = 1:length(OutputDynamicRaw)
    RPM = OutputDynamicRaw(i).RPMs;
    OutputDynamic(i).J = OutputDynamicRaw(i).Freestream/((RPM/60)*D);
    OutputDynamic(i).Ct = OutputDynamicRaw(i).Thrust/(rho*(RPM/60)^2*D^4);
    OutputDynamic(i).Cp = 2*pi*OutputDynamicRaw(i).Torque/(rho*(RPM/60)^2*D^5);
end
OutputDynamic = struct2table(OutputDynamic);
OutputStat    = struct2table(OutputStat);
%% Plotting
%Static
figure()
subplot(1,2,1)
plot(expDataStat.RPM,expDataStat.Ct0,'r*');
grid on
grid minor
hold on
plot(OutputStat.RPM,OutputStat.Ct0,'--b');
plot(apc9x47sf_static_th.RPM,apc9x47sf_static_th.CT,'bx');
hold off
xlabel("RPM")
ylabel("Ct0")

subplot(1,2,2);
plot(expDataStat.RPM,expDataStat.Cp0,'r*');
grid on
grid minor
hold on
plot(OutputStat.RPM,OutputStat.Cp0,'--b');
plot(apc9x47sf_static_th.RPM,apc9x47sf_static_th.CP,'bx');
hold off
xlabel("RPM")
ylabel("Cp0")

%dynamic
figure()
subplot(1,2,1)
plot(expDataDynamic.J,expDataDynamic.Ct,'r*');
grid on
grid minor
hold on
plot(OutputDynamic.J,OutputDynamic.Ct,'--b');
plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CT,'bx');
hold off
xlabel("J")
ylabel("Ct")

subplot(1,2,2);
plot(expDataDynamic.J,expDataDynamic.Cp,'r*');
grid on
grid minor
hold on
plot(OutputDynamic.J,OutputDynamic.Cp,'--b');
plot(apc9x47sf_6029_th.J,apc9x47sf_6029_th.CP,'bx');
hold off
xlabel("J")
ylabel("Cp")
