function [dataOut, timeOut]=pageCutReading(pathOfDirectoryContainingJFile,finputf,timeTargetLower,timeTargetHigher,IgnoringLineNumber)

fname=sprintf('%s%s',pathOfDirectoryContainingJFile,finputf);
fid=fopen(fname,'r');


counter = 0;
while ~feof(fid)
    tline0=fgetl(fid);
    if strfind(tline0,'TIME')~= 0
        counter=counter+1;
        t0=strfind(tline0,'=');
        t1=strfind(tline0,'s');
        tt=str2num(tline0(t0+1:t1-1)); % time (sec)        
        
        if ((tt>=timeTargetLower) && (tt<=timeTargetHigher))
            timeOut=tt;
            for i=1:IgnoringLineNumber
                fgetl(fid);
            end
            for i=1:50
                tline1=fgetl(fid);
                tline1=strrep(tline1,'th','0');
                tline1=strrep(tline1,'lm','0');
                tline1=strrep(tline1,'nc','0');
                dataOut(i,:)=str2num(tline1);
            end
            fclose(fid);
            return;
        end
    end    
end

end