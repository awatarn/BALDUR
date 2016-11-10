function [TimeNBe,NBe_avg] = ReadNBe(pathOfDirectoryContainingJFile,finputf)
% Read the confinement time for a specific element
% Use this function with ExtractConfinementTimeFromJFile()
% Last update: June 3, 2016

    temp1 = sprintf('Read the confinement time by functon ReadNBe()...');
    disp(temp1)
    
    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
    fid=fopen(fname,'r');
    HeaderOffset = 1;

    counter = -HeaderOffset+1;
    TimeNBe = [];
    while ~feof(fid)
        tline0=fgetl(fid);
%         if counter ==1
%             tempd = str2num(tline0);
%             Radii = tempd;
%         end
        if counter >=2
            tempd=str2num(tline0);
            TimeNBe = [TimeNBe; tempd];
        end
        counter = counter+1;
    end
    NBe_avg = mean(TimeNBe(floor(0.90*length(TimeNBe)):length(TimeNBe),2));
    fclose(fid);
end