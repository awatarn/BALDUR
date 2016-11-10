function [TimeSldwnT,SldwnT_avg] = ReadAverageSlowingDowTime(pathOfDirectoryContainingJFile,finputf)
% Read the confinement time for a specific element
% Use this function with ExtractConfinementTimeFromJFile()
% Last update: June 3, 2016

    temp1 = sprintf('Read the slowing down time by functon ReadAverageSlowingDowTime()...');
    disp(temp1)
    
    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
    fid=fopen(fname,'r');
    HeaderOffset = 1;

    counter = -HeaderOffset+1;
    TimeSldwnT = [];
    while ~feof(fid)
        tline0=fgetl(fid);
        if counter >=2
            tempd=str2num(tline0);
            TimeSldwnT = [TimeSldwnT; tempd];
        end
        counter = counter+1;
    end
    temp1 = mean(1./TimeSldwnT(floor(0.95*length(TimeSldwnT)):length(TimeSldwnT),2));
    SldwnT_avg = 1./temp1;
    fclose(fid);
end