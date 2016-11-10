function [Radii,TimeTau4,Tau4_avg] = ReadConfinementTime(pathOfDirectoryContainingJFile,finputf)
% Read the confinement time for a specific element
% Use this function with ExtractConfinementTimeFromJFile()
% Last update: June 3, 2016

    temp1 = sprintf('Read the confinement time by functon ReadConfinementTime()...');
    disp(temp1)
    
    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
    fid=fopen(fname,'r');
    HeaderOffset = 1;

    counter = -HeaderOffset+1;
    TimeTau4 = [];
    while ~feof(fid)
        tline0=fgetl(fid);
        if counter ==1
            tempd = str2num(tline0);
            Radii = tempd;
        end
        if counter >=2
            tempd=str2num(tline0);
            TimeTau4 = [TimeTau4; tempd];
        end
        counter = counter+1;
    end
    Tau4_avg = mean(TimeTau4(floor(0.8*length(TimeTau4)):length(TimeTau4),2:5));
    fclose(fid);
end