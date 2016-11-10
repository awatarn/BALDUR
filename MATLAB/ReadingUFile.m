function [X,Y,FXY] = ReadingUFile(DirectoryContainingData,File2dName,DepVarLabel)

%% Reading U-File format (2D data)
% Created by A.W. 2 March 2016
% clear
% clc
% close all
%% Input
disp('ReadingUFile (2D) Status: Initialized')

% DirectoryContainingData = sprintf('/Users/Apiwat/Research_plasma/0 Profile Database/2 ReadingDataMatlab/DataBox');
% File2dName = sprintf('pr08_jet_53212_2d.dat.txt');
% DepVarLabel = 'NE ';

FullPathFile2D = sprintf('%s/%s',DirectoryContainingData,File2dName);

temptext1=sprintf('Reading data from:\n%s',FullPathFile2D);
temptext2=sprintf('Dependent varaible: %s',DepVarLabel);

disp(temptext1)
disp(temptext2)
%% Internal variables
isDepVarLabel = 0;
lenX = 0;
lenY = 0;
isEndOfData = 0;

RetrievingDataIndex = 0;
%% Reading data
fid1 = fopen(FullPathFile2D,'r');
lineNo=0;
while isEndOfData~=1
    
    tline = fgetl(fid1);
%     disp(tline);
    lineNo=lineNo+1;
    
    kDepVarLabel = strfind(tline,DepVarLabel);
    kXPTS = strfind(tline,'OF X PTS-');
    kYPTS = strfind(tline,'OF Y PTS-');
    kEnd = strfind(tline,'END-OF-DATA');
    
    if (isempty(kDepVarLabel)~= 1) && (isDepVarLabel == 0)
        disp('Actual reading variable:')
        disp(tline)
        isDepVarLabel = 1;
    end
    
    if (isempty(kXPTS) ~= 1) && (lenX == 0) && (isDepVarLabel == 1)
%         disp(tline);
        startIndex = regexp(tline,';');
        lenX = str2num(tline(1:startIndex-1));
        X = ones(lenX,1).*0;
    end
    
    if (isempty(kYPTS) ~= 1) && (lenY == 0) && (isDepVarLabel == 1)
%         disp(tline);
        startIndex = regexp(tline,';');
        lenY = str2num(tline(1:startIndex-1));
        lenXY = lenX*lenY;
        Y = ones(lenY,1);
        FXY = ones(lenX,lenY);
        continue
    end
    
    if (isempty(kEnd) ~= 1) && (isDepVarLabel == 1)
        isEndOfData = 1;
    end
    
    if lenY>0
        startIndex = regexp(tline,' ');
        startIndex = [startIndex length(tline)];
        for i=2:length(startIndex)-1
            tempx = str2num(tline(startIndex(i):startIndex(i+1)));
            
            RetrievingDataIndex = RetrievingDataIndex+1;
%             disp(RetrievingDataIndex);
            if RetrievingDataIndex<=lenX
                X(RetrievingDataIndex,1) = tempx;
            elseif RetrievingDataIndex>lenX && RetrievingDataIndex <=(lenX+lenY)
                Y(RetrievingDataIndex-lenX,1) = tempx;
            else
                FXY(RetrievingDataIndex-lenX-lenY) = tempx;
            end
        end
    end
    
end
fclose(fid1);

disp('ReadingUFile Status: Done')

%% Sample script for using this file
% %% Initialize
% clear
% close all
% clc
% %% Input
% DirectoryContainingData = sprintf('/Users/Apiwat/Research_plasma/0 Profile Database/2 ReadingDataMatlab/DataBox');
% File2dName = sprintf('pr08_jet_53212_2d.dat.txt');
% DepVarLabel = 'NE ';
% 
% timeA = 57.850;
% timeB = 57.870;
% %% Process
% 
% [rminor,time,NE] = ReadingUFile(DirectoryContainingData,File2dName,DepVarLabel);
% time=time+40;
% 
% 
% timeIndexA = find(time>=timeA);
% timeIndexA = min(timeIndexA);
% 
% timeIndexB = find(time>=timeB);
% timeIndexB = min(timeIndexB);
% 
% figure();
% plot(time-40,mean(NE),'-o');
% 
% figure();
% plot(time,mean(NE),'-o');
% 
% figure();
% plot(rminor,NE(:,timeIndexA),'-ro',rminor,NE(:,timeIndexB),'-bo');
% 
% temptext1=sprintf('t=%.4f s',time(timeIndexA));
% temptext2=sprintf('t=%.4f s',time(timeIndexB));
% legend(temptext1,temptext2);

