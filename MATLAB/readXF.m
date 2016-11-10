%     APIWAT WISITSORASAK CREATED ON JAN 14, 2009
%     PURPOSE: READ AND EXTRACT DATA FROM *XF.PLN FILE
%     IMPLEMENTED VARIABLES:
%     FINPUT = INPUT FILE NAME
%     VAR1 = THE FIRST VARIABLE NAME
%     VAR2 = THE SECOND VARIABLE NAME
%     TI = INTIAL TIME FOR KEEPING DATA
%     TI = FINAL TIME FOR KEEPING DATA
%     TSTEP = INTERVAL TIME FOR KEEPING DATA
%     OUTPUT1 = OUTPUT 1
%     OUTPUT2 = OUTPUT 2
%     OUTPUT3 = TIME SERIES
%     END

function [output1,output2,output3]=readXF(finput,var1,var2,ti,tf,tstep)
count = 0;
tbar=ti;
fid=fopen(finput);
step=50;

while ~feof(fid)
    tline=fgetl(fid);
    if (strfind(tline,'TIME')~= 0)  % get time first
        tline=fgetl(fid);
        time=str2num(tline);
        if time>tf
            continue
        end
        count = count+1 ;
    end % strfind(tline,'TIME')~= 0
    
    if strfind(tline,var1)~= 0 % get Rminor 
       tline=fgetl(fid);
       temp1 (1:6)=str2num (tline);
       tline=fgetl(fid);
       temp1 (7:12)=str2num(tline);
       tline=fgetl(fid);
       temp1 (13:18)=str2num(tline);
       tline=fgetl(fid);
       temp1 (19:24)=str2num(tline);
       tline=fgetl(fid);
       temp1 (25:30)=str2num(tline);
       tline=fgetl(fid);
       temp1 (31:36)=str2num(tline);
       tline=fgetl(fid);
       temp1 (37:42)=str2num(tline);
       tline=fgetl(fid);
       temp1 (43:48)=str2num(tline);
       tline=fgetl(fid);
       temp1 (49:50)=str2num(tline);
    end %strfind(tline,var1)~= 0 % get Rminor
    
    if strfind(tline,var2)~= 0 % get Ydat
       tline=fgetl(fid);
       temp2 (1:6)=str2num (tline);
       tline=fgetl(fid);
       temp2 (7:12)=str2num(tline);
       tline=fgetl(fid);
       temp2 (13:18)=str2num(tline);
       tline=fgetl(fid);
       temp2 (19:24)=str2num(tline);
       tline=fgetl(fid);
       temp2 (25:30)=str2num(tline);
       tline=fgetl(fid);
       temp2 (31:36)=str2num(tline);
       tline=fgetl(fid);
       temp2 (37:42)=str2num(tline);
       tline=fgetl(fid);
       temp2 (43:48)=str2num(tline);
       tline=fgetl(fid);
       temp2 (49:50)=str2num(tline);
       % get all temp2
    end %strfind(tline,var2)~= 0 % get temp2
    
    if ((time>=tbar) && (time<=tf) && (exist('temp1','var')==1) && (exist('temp2','var')==1))
        
        if exist('output3','var')==0
            output3=time;
            output2=temp2;
            output1=temp1;
%             output3=ones(1,50)*time;
%             output1=temp1;
%             output2=temp2;
            clear temp1 temp2
        else
            output3=[output3 time];
            output2=[output2; temp2];
%             temp10=size(output2);
%             temp11=temp10(1,1)+1
%             output2(temp11,:)=output2;
%             output1=[output1 temp1];
%             output3=[output3 ones(1,50)*time];
%             output1=[output1 temp1];
%             output2=[output2 temp2];
            clear temp1 temp2
        end
        tbar=tbar+tstep;
    end
    
end
fclose(fid);

end

