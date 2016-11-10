function ExtractDataFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,VariableName)

display('ExtractDataFromJFile() is working. ;-)')
display(strFilterPageNo)
display(VariableName)

cd(pathOfDirectoryContainingJFile);

tempFile=sprintf('%s%s',pathOfDirectoryContainingJFile,foutput);
if exist(tempFile,'file')~=0
    sprintf('%s already exists in %s.\nThe function ExtractDataFromJFile is skipped.',foutput,jFileName)
    return
end


finput=jFileName;

fid=fopen(finput);
fout=fopen(foutput,'w');

checkPageNo = 0;
counter = 0;
while ~feof(fid)
    tline0=fgetl(fid);
%     checkPageNo
    if strfind(tline0,strFilterPageNo)~= 0
        checkPageNo = 1;
        counter = counter + 1
        t0=strfind(tline0,'=');
        t1=strfind(tline0,'millisecs');
        tt=str2num(tline0(t0+1:t1-1))/1000; % time (sec)
    end
    if checkPageNo == 1
        if (strfind(tline0,VariableName) ~= 0)
%             tline0;
            tline2 = fgetl(fid);
            temp1 = sprintf('TIME = %.6f s',tt);
            fprintf(fout,'%s\n',temp1);
            fprintf(fout,'%s\n',tline0);
            if strfind(tline2,'kev') ~=0 % skip a line of the unit name and the following line (for the density field)
                tline2=fgetl(fid);
                tline2=fgetl(fid);
            end
            fprintf(fout,'%s\n',tline2);
            for i = 1:51
                tline2=fgetl(fid);                
                tline2=strrep(tline2,'- ','  '); % replace illegal characters
                tline2=strrep(tline2,'o ','  '); % replace illegal characters
                fprintf(fout,'%s\n',tline2);
            end
            fprintf(fout,'\n');
            checkPageNo = 0;
        end
    end
end
fclose(fid);
fclose(fout);

sprintf('===============SUMMARY=========================')
sprintf('Reading data from %%s \n and writing data to %s \n are complete :-)',pathOfDirectoryContainingJFile,finput,foutput)
sprintf('The number of data is %d.',counter)
sprintf('===============SUMMARY=========================')

end
