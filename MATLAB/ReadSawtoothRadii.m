function [Radii,TimeR4,R4_avg] = ReadSawtoothRadii(pathOfDirectoryContainingJFile,finputf)
% Read the confinement time for a specific element
% Use this function with ExtractConfinementTimeFromJFile()
% Last update: June 16, 2016
% R4 = [r_mix r_inv r_q1 a]

    temp1 = sprintf('Read the confinement time by functon ReadSawtoothRadii()...');
    disp(temp1)
    
    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
    fid=fopen(fname,'r');
    HeaderOffset = 1;

    counter = -HeaderOffset+1;
    TimeR4 = [];
    while ~feof(fid)
        tline0=fgetl(fid);
        if counter ==1
            tempd = str2num(tline0);
            Radii = tempd;
        end
        if counter >=2
            tempd=str2num(tline0);
            TimeR4 = [TimeR4; tempd];
        end
        counter = counter+1;
    end
    size(TimeR4)
    R4_avg = mean(TimeR4(floor(0.8*length(TimeR4)):length(TimeR4),2:5));
    fclose(fid);
end