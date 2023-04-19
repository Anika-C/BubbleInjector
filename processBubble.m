% Anika Cho
% Dorgan Lab, Summer 2022
% Updated April 2023

% Bubble Injection Method - Data Processing
% Calculates fracture toughness (KIc) from pressure sensor data 
% Generates Pressure (Pa) vs. Time (s) plot 
% Determines the critical peak pressure (Ppeak)

% User-Configurable Parameters (Command Window Input):
% filename: name of SD Card log file
% needleSize: gauge of dispensing needle (14G for mud, 22G for jello)


close all, clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set program parameters & variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% File Name Input
disp('File Name Example: BUBBLE00.CSV');
filename=input('Input file name: ', 's');
disp(' ');
if isempty(filename)
   disp('ERROR: No filename input');
end

M = readmatrix(filename);

% Needle Size Input
disp('Needle Size: (0)14G-Mud or (1)22G-Jello');
needleSize=input('Please select needle size (default=0): ');
disp(' ');
if isempty(needleSize)
   needleSize=0; 
end

%Set Needle Diameter 
if needleSize==0
    Din = 1.09; %from hamiltoncompany.com (Point Style 5 Specifications), 14G port diameter = 1.09(mm)
end

if needleSize==1
    Din = 0.25; %from hamiltoncompany.com (Point Style 5 Specifications), 22G port diameter = 0.25(mm)
end

Rin = Din/2000; %inner radius of needle (m)
nu = 0.5; %Poisson's ratio for muddy sediments, from L Esperance et al. 2012

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Pressure vs. Time & Critical Peak Pressure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% X-Axis - Time
Millis = M(:, 1); %time (in milliseconds) from log file
startTime = Millis(1); %find starting time (ms since Arduino Zero reset/power on)
time = (Millis - startTime)/1000; %Convert ms to s, subtract startTime to start plot at 0s

% Y-Axis - Pressure
Pressure = M(:,2); %pressure sensor readings from log file (in PSI)
pressPa = Pressure * 6894.76; %convert PSI to Pa (1 Pa = 1 (kg)/(m*s^2)
pressPaS = smoothdata(pressPa,'gaussian',101); %smooth pressure sensor data

% Plot Pressure vs. Time
figure
plot(time, pressPa)
hold on
plot(time, pressPaS,'k-')

ylabel('pressure (Pa)')
xlabel('time (s)')

% Find critical peak pressure
PbaseInd = [500 5000]; %index range for baseline pressure
Pbase = mean(pressPa(PbaseInd(1):PbaseInd(2))); %find baseline pressure
netPress = pressPaS - Pbase; %net change in pressure
[Ppeak,PpeakInd] = max(netPress); %find peak pressure

% Plot critical peak pressure
hold on
plot(time(PpeakInd),Ppeak+Pbase,'r*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Fracture Toughness From Critical Peak Pressure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate EGc and KIc
EGc = Ppeak^2*3*Rin/pi; %from Barney et al. 2019
KIc = sqrt(EGc/(1-nu^2)); %from Barney et al. 2019


