function ExtractTIaxisFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,VariableName)

% clc

% pathOfDirectoryContainingJFile='/Users/Apiwat/Research_plasma/2 DEMOs/2 Simulations/2 Run with baldur_banjerd/China/a03/';
% jFileName='jchinaa03';
% foutput='pageCut_24.txt';
% strFilterPageNo='-24-';
% VariableName='helium-3   confinement time';



display('ExtractTIaxisFromJFile() is working. ;-)')
display(strFilterPageNo)
display(VariableName)

cd(pathOfDirectoryContainingJFile);

tempFile=sprintf('%s%s',pathOfDirectoryContainingJFile,foutput);
if exist(tempFile,'file')~=0
    sprintf('%s already exists in %s.\nThe function ExtractTIaxisFromJFile is skipped.',foutput,jFileName)
    return
end


finput=jFileName;

fid=fopen(finput);
fout=fopen(foutput,'w');

checkPageNo = 0;
checkVariable = 0;
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
        temp1 = sprintf('TIME = %10.4f s',tt);
        disp(temp1)
    end
    
    if checkPageNo==1 % copy confinement time at each radius
        if (strfind(tline0,VariableName) ~= 0)
%             tline0
            checkVariable = 1;
            TIaxis = str2num(tline0(47:57));
        end
    end
    
    if checkVariable == 1 % save data with new format
        checkPageNo = 0;
        checkRadiusLine = 0;
        checkVariable = 0;
        if counter == 1
            fprintf(fout,'  TIME (S)     TI-AXIS\n');
            fprintf(fout,'                 [keV]\n');
        end
        fprintf(fout,'%10.4f  %10.4f\n',tt,TIaxis);
        
        
    end
end
fclose(fid);
fclose(fout);

sprintf('===============SUMMARY=========================')
sprintf('Reading data from %%s \n and writing data to %s \n are complete :-)',pathOfDirectoryContainingJFile,finput,foutput)
sprintf('The number of data is %d.',counter)
sprintf('===============SUMMARY=========================')

end
