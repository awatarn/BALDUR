function ExtractSawtoothRadiiFromJFile(pathOfDirectoryContainingJFile,jFileName,foutput,strFilterPageNo,VariableName)

% clc

% pathOfDirectoryContainingJFile='/Users/Apiwat/Research_plasma/2 DEMOs/2 Simulations/2 Run with baldur_banjerd/China/a03/';
% jFileName='jchinaa03';
% foutput='pageCut_24.txt';
% strFilterPageNo='-24-';
% VariableName='helium-3   confinement time';



display('ExtractSawtoothRadiiFromJFile() is working. ;-)')
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
        t0=strfind(tline0,'time');
        t1=strfind(tline0,'sec');
        tt=str2num(tline0(t0+5:t1-1)); % time (sec)
        temp1 = sprintf('TIME = %10.4f s',tt);
        disp(temp1)
    end
    
    if checkPageNo == 1 % copy radii
        if (strfind(tline0,VariableName) ~= 0)
%             tline0
            checkRadiusLine = 1;
            R1 = str2num(tline0(50:56)); % r(mix)
            R2 = str2num(tline0(70:76)); % r(inversion)
            R3 = str2num(tline0(84:90)); % r(q1)
            R4 = str2num(tline0(93:99))/0.95; % rminor (radius to the LCFS)
        end
    end
    
    if checkRadiusLine == 1 % save data with new format
        checkPageNo = 0;
        checkRadiusLine = 0;
        if counter == 1
            fprintf(fout,'  TIME          r_mix       r_inv      r_q1          a \n');
            fprintf(fout,'   (s)           (cm)        (cm)      (cm)         (cm) \n');
        end
        fprintf(fout,'%10.4f  %10.4f  %10.4f  %10.4f  %10.4f \n',tt,R1,R2,R3,R4);
        
        
    end
    
%     if counter>=10
%         break
%     end
end
fclose(fid);
fclose(fout);

sprintf('===============SUMMARY=========================')
sprintf('Reading data from %%s \n and writing data to %s \n are complete :-)',pathOfDirectoryContainingJFile,finput,foutput)
sprintf('The number of data is %d.',counter)
sprintf('===============SUMMARY=========================')

end
