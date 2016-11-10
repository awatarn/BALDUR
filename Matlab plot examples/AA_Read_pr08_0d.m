%%
clc
clear
close all
%%
% ShotNo = '46290';
% ShotNo = '45980';
% ShotNo = '45984';
% ShotNo = '46290';
% ShotNo = '46291';
% ShotNo = '52179';
% ShotNo = '52182';
% ShotNo = '52183';
% ShotNo = '52184';
% ShotNo = '52186';
% ShotNo = '52187';
% ShotNo = '52233';
% ShotNo = '105290';
ShotNo = '69627';

% TokName = 'tftr';
% FolderPath = sprintf('/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/%s_exp',ShotNo);

TokName = 'd3d';
FolderPath = sprintf('/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/02_D3D/%s_exp',ShotNo);

PR08Filename = sprintf('pr08_%s_%s_0d.dat',TokName,ShotNo);
PR08Path = sprintf('%s/%s',FolderPath,PR08Filename);
%% Reading data
fid1 = fopen(PR08Path,'r');
lineNo=0;
%%
% while lineNo==0%~feof(fid1)
while ~feof(fid1)    
    
    lineNo = lineNo+1;
    
    tline = fgetl(fid1);
%     disp(tline);

    if lineNo == 1
        kcomma1 = strfind(tline,','); % position of comman in the first line
        kTIME1 = strfind(tline,',TIME,');   % position of ,TIME, in the first line
        kcomma1TIME = find(kcomma1==kTIME1);
    elseif lineNo == 2
        kcomma2 = strfind(tline,',');
        kcomma2TIMEleft = kcomma2(kcomma1TIME)+1;
        kcomma2TIMEright = kcomma2(kcomma1TIME+1)-1;
        TIME = str2num(tline(kcomma2TIMEleft:kcomma2TIMEright));
    end
    length(kcomma1);
end
temp1 = sprintf('Time provided in %s is given at %.4f s',PR08Filename,TIME);
disp(temp1)

