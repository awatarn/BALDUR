function [Radii,TimeTau,Tau_avg] = ReadTauITER98(pathOfDirectoryContainingJFile,finputf)
% Read the confinement time for a specific element
% Use this function with ExtractConfinementTimeFromJFile()
% Last update: June 3, 2016

    temp1 = sprintf('Read the confinement time by functon ReadTauITER98()...');
    disp(temp1)
    
    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
    fid=fopen(fname,'r');
    HeaderOffset = 1;

    counter = -HeaderOffset+1;
    TimeTau = [];
    while ~feof(fid)
        tline0=fgetl(fid);
        if counter ==1
            tempd = str2num(tline0);
            Radii = tempd;
        end
        if counter >=2
            tempd=str2num(tline0);
            TimeTau = [TimeTau; tempd];
        end
        counter = counter+1;
    end
    Tau_avg = mean(TimeTau(floor(0.90*length(TimeTau)):length(TimeTau),2));
    fclose(fid);
end