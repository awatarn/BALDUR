function [X,FX,AVG,IERR] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel,TokName)

% DirectoryContainingData = sprintf('/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/%s_exp',DischargeNo);
File1dName1 = sprintf('pr08_%s_%s_1d.dat',TokName,DischargeNo);
File1dName2 = sprintf('%s_%s_1d.dat',TokName,DischargeNo);

% DepVarLabel = ' AMIN ';
ExportFileName = sprintf('list-exp-%s-%s.dat',DischargeNo,DepVarLabel);

%% Input
disp(' ')
disp('ConvertingUFile1DtoSlistFormat (1D) Status: Initialized')

FullPathFile1 = sprintf('%s/%s',DirectoryContainingData,File1dName1);
FullPathFile2 = sprintf('%s/%s',DirectoryContainingData,File1dName2);

if (exist(FullPathFile1,'file') == 2)
    File1dName = File1dName1;
elseif (exist(FullPathFile2,'file') == 2)
    File1dName = File1dName2;
end

FullPathFile = sprintf('%s/%s',DirectoryContainingData,File1dName);

temptext1=sprintf('Reading data from:\n%s',FullPathFile);
temptext2=sprintf('Dependent varaible: %s',DepVarLabel);

disp(temptext1)
disp(temptext2)


%% Internal variables
isDepVarLabel = 0;
lenX = 0;
isEndOfData = 0;

RetrievingDataIndex = 0;
%% Reading data
fid1 = fopen(FullPathFile,'r');
lineNo=0;
while isEndOfData~=1 && ~feof(fid1)
    
    tline = fgetl(fid1);
%     disp(tline);
    lineNo=lineNo+1;
    
    kDepVarLabel = strfind(tline,DepVarLabel);
    kXPTS = strfind(tline,';-# OF PTS-  X,');
    kEnd = strfind(tline,'END-OF-DATA');
    
    if (isempty(kDepVarLabel)~= 1) && (isDepVarLabel == 0)
        disp('Scanner found the reading variable; Line excerpted from the source file:')
        disp(tline);
        isDepVarLabel = 1;
    end
    
    if (isempty(kXPTS) ~= 1) && (lenX == 0) && (isDepVarLabel == 1) % time series
%         disp(tline);
        startIndex = regexp(tline,';');
        lenX = str2num(tline(1:startIndex-1));
        X = ones(lenX,1).*0;
        FX = X;
        continue
    end
    
    if (isempty(kEnd) ~= 1) && (isDepVarLabel == 1)
        isEndOfData = 1;
        continue
    end
%% CONVERTING STRING DATA INTO NUMBER DATA BY LOCATING LETTER 'E'    
    if lenX>0 && isEndOfData == 0
%         disp(tline)
        startIndex = regexp(tline,'E');
        AIndex = startIndex-9;
        BIndex = startIndex+3;
        for i=1:length(AIndex)
            tempx = str2num(tline(AIndex(i):BIndex(i)));
            RetrievingDataIndex = RetrievingDataIndex+1;
            if RetrievingDataIndex<=lenX
                X(RetrievingDataIndex,1) = tempx;
            else
                FX(RetrievingDataIndex-lenX,1) = tempx;
            end
        end        
    end
    
%% THIS PART OF THE SCRIPT IS USED TO CONVERT STRING DATA INTO NUMBER DATA.
%  EACH STRING IS ASSUMED TO BE SEPARATED BY A SINGLE SPACE, BUT THIS IS
%  THE CASE FOR SOME VARIABLES SUCH AS BT AND DELTA. THEREFORE OTHER
%  CRITERION IS NEEDED. ONE POSSIBLE WAY IS TO LOCATE EACH NUMBER DATA BY
%  LETTER 'E'.
%     if lenX>0
%         startIndex = regexp(tline,' ');
%         startIndex = [startIndex length(tline)];
%         for i=2:length(startIndex)-1
%             tempx = str2num(tline(startIndex(i):startIndex(i+1)));
%             
%             RetrievingDataIndex = RetrievingDataIndex+1;
%             if RetrievingDataIndex<=lenX
%                 X(RetrievingDataIndex,1) = tempx;
%             else
%                 FX(RetrievingDataIndex-lenX) = tempx;
%             end
%         end
%     end
%%    
end

if isDepVarLabel == 0
    IERR = 1; % not found the dependent variable
    temp1 = sprintf('[ERROR] %s has not been found!',DepVarLabel);
    X=1:100;
    FX=1:100;
elseif isDepVarLabel == 1 && isEndOfData == 1
    IERR = 0; % normal exit
end

fclose(fid1);

AVG = mean(FX(floor(0.9*length(FX)):length(FX)));
disp('ConvertingUFile1DtoSlistFormat (1D) Status: Reading = Done')

if IERR>0
    AVG = -999;
end

%% Save data

FullPathFile = sprintf('%s/%s',DirectoryContainingData,ExportFileName);
fileID = fopen(FullPathFile,'w');

fprintf(fileID,'# Trace from filein = %s\n',FullPathFile);
fprintf(fileID,'#   time        %s\n',DepVarLabel);
for i=1:length(X)
    fprintf(fileID,'   %.4e   %.4e\n',X(i),FX(i));
end
fclose(fileID);
disp('ConvertingUFile1DtoSlistFormat (1D) Status: Writing slist file = Done')



