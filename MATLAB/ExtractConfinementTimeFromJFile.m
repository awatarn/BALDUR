function ExtractConfinementTimeFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,VariableName)

% clc

% pathOfDirectoryContainingJFile='/Users/Apiwat/Research_plasma/2 DEMOs/2 Simulations/2 Run with baldur_banjerd/China/a03/';
% jFileName='jchinaa03';
% foutput='pageCut_24.txt';
% strFilterPageNo='-24-';
% VariableName='helium-3   confinement time';



display('ExtractConfinementTimeFromJFile() is working. ;-)')
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
checkRadiusLine = 0;
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
    
    if checkPageNo == 1 % copy radii
        if (strfind(tline0,'radius (') ~= 0)
%             tline0
            checkRadiusLine = 1;
            R1 = str2num(tline0(54:66));
            R2 = str2num(tline0(66:79));
            R3 = str2num(tline0(79:92));
            R4 = str2num(tline0(92:length(tline0)));
        end
    end
    
    if checkRadiusLine==1 % copy confinement time at each radius
        if (strfind(tline0,VariableName) ~= 0)
%             tline0
            checkVariable = 1;
            tau1 = str2num(tline0(54:66));
            tau2 = str2num(tline0(66:79));
            tau3 = str2num(tline0(79:92));
            tau4 = str2num(tline0(92:length(tline0)));
        end
    end
    
    if checkVariable == 1 % save data with new format
        checkPageNo = 0;
        checkRadiusLine = 0;
        checkVariable = 0;
        if counter == 1
            fprintf(fout,'  TIME (S)          r1          r2         r3         r4 \n',R1,R2,R3,R4);
            fprintf(fout,'                 %3.2f      %3.2f      %3.2f      %3.2f \n',R1,R2,R3,R4);
        end
        fprintf(fout,'%10.4f  %10.4f  %10.4f  %10.4f  %10.4f \n',tt,tau1,tau2,tau3,tau4);
        
        
    end
end
fclose(fid);
fclose(fout);

sprintf('===============SUMMARY=========================')
sprintf('Reading data from %%s \n and writing data to %s \n are complete :-)',pathOfDirectoryContainingJFile,finput,foutput)
sprintf('The number of data is %d.',counter)
sprintf('===============SUMMARY=========================')

end
