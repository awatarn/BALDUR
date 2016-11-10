function pageCutFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,strFilterLongName,timeInitial,timeFinal)
clc

display('pageCutFromJFile() is working. ;-)')

% finput='C:\Research (Plasma)\Simulation Pellet\p-series\p001\jiterp001';
% foutput='C:\Research (Plasma)\Simulation Pellet\p-series\p001\pageCut.txt';

% pathOfDirectoryContainingJFile='C:\Research (Plasma)\Simulation Pellet\p-series\p001\';
% jFileName='jiterp001';
cd(pathOfDirectoryContainingJFile);

tempFile=sprintf('%s%s',pathOfDirectoryContainingJFile,foutput);
if exist(tempFile,'file')~=0
    sprintf('%s already exists.\nThe function pageCutReading is skipped.',jFileName)
    return
end

% foutput='pageCut.txt';

% strFilterPageNo='- 8-';
% strFilterLongName='hydrogenic particle diffusion coefficients';

finput=jFileName;
fid=fopen(finput);
fout=fopen(foutput,'w');

% timeInitial=0;
% timeFinal=700;

counter = 0;
while ~feof(fid)
    tline0=fgetl(fid);
    if strfind(tline0,strFilterPageNo)~= 0
        counter=counter+1
        t0=strfind(tline0,'=');
        t1=strfind(tline0,'millisecs');
        tt=str2num(tline0(t0+1:t1-1))/1000; % time (sec)
        
        if ((tt>=timeInitial) && (tt<=timeFinal))
            fgetl(fid);
            tline2=fgetl(fid);
            if strfind(tline2,strFilterLongName)~= 0
                fprintf (fout,'%s\n',tline0); 
                fprintf (fout,'%s\n',tline2); 
                for i=1:55
                    tline2=fgetl(fid);
                    fprintf (fout,'%s\n',tline2);
                end
            end                                            
        end                                
    end            
end
fclose(fid); fclose(fout);

sprintf('===============SUMMARY=========================')
sprintf('Reading data from %%s \n and writing data to %s \n are complete :-)',pathOfDirectoryContainingJFile,finput,foutput)
sprintf('The number of data is %d.',counter)
sprintf('===============SUMMARY=========================')

end