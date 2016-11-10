%% Initialize
clear
close all
clc
%% Input
DirectoryContainingData = sprintf('/Users/Apiwat/Research_plasma/0 Profile Database/2 ReadingDataMatlab/DataBox');
File2dName = sprintf('pr08_jet_53212_2d.dat.txt');
DepVarLabel = 'NE ';

timeA = 57.80;
timeB = 57.90;

% timeA = 58.20;
% timeB = 59.22;
%% Process

[rminor,time,NE] = ReadingUFile(DirectoryContainingData,File2dName,DepVarLabel);
time=time+40;


timeIndexA = min(find(time>=timeA));

timeIndexB = min(find(time>=timeB));

figure();
plot(time-40,mean(NE),'o');

figure();
plot(time,mean(NE),'o');
xlim([54,62])
ylim([0 2e20]);

figure();
plot(rminor,NE(:,timeIndexA),'ro',rminor,NE(:,timeIndexB),'bo');

temptext1=sprintf('t=%.4f s',time(timeIndexA));
temptext2=sprintf('t=%.4f s',time(timeIndexB));
legend(temptext1,temptext2);

figure();
[X,Y]=meshgrid(time,rminor);
surf(X,Y,NE);
zlabel('NE');
xlabel('time');
ylabel('r');



