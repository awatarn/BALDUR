function ExtractDataFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,VariableName)
clc

display('pageCutFromJFile() is working. ;-)')
display(strFilterPageNo)
display(VariableName)

cd(pathOfDirectoryContainingJFile);

tempFile=sprintf('%s%s',pathOfDirectoryContainingJFile,foutput);
if exist(tempFile,'file')~=0
    sprintf('%s already exists in %s.\nThe function pageCutReading is skipped.',foutput,jFileName)
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
        counter = counter + 1;
        t0=strfind(tline0,'=');
        t1=strfind(tline0,'millisecs');
        tt=str2num(tline0(t0+1:t1-1))/1000; % time (sec)
        temp1 = sprintf('counter=%d\ttime=%.4f',counter,tt);
        disp(temp1)
    end
    if checkPageNo == 1
        if (strfind(tline0,VariableName) ~= 0)
%             tline0;
%             size(tline0)
            data0 = tline0(45:length(tline0));
            if counter==1
                temp1 = sprintf('# Total current data obtained from %s',pathOfDirectoryContainingJFile);
                fprintf(fout,'%s\n',temp1);
                temp1 = sprintf('  TIME        <J_tor>     <J_drive>    <J_boot>     <J_tpb>');
                fprintf(fout,'%s\n',temp1);
                temp1 = sprintf('    s          MA/m**2     MA/m**2     MA/m**2     MA/m**2');
                fprintf(fout,'%s\n',temp1);
            end
            temp1 = sprintf('%.4e   %s',tt,data0);
            fprintf(fout,'%s\n',temp1);
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
