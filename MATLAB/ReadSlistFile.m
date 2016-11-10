function [TimeData,Average] = ReadSlistFile(pathOfDirectoryContainingJFile,filename)
    temp1 = sprintf('Read slist-data (%s) by functon ReadSlistFile()...',filename);
    disp(temp1)

    fname=sprintf('%s%s',pathOfDirectoryContainingJFile,filename);
    fid=fopen(fname,'r');
    HeaderOffset = 2;

    counter = -HeaderOffset+1;
    TimeData = [];
    while ~feof(fid)
        tline0=fgetl(fid);
        if counter >=1
            tempd=str2num(tline0);
            TimeData = [TimeData; tempd];
        end
        counter = counter+1;
    end
    Average = mean(TimeData(floor(0.8*length(TimeData)):length(TimeData),2));
    fclose(fid);
end