clc
clear
close all
%%
ExcelFilename = 'AA_SummaryDischargeData.xls';
sheetName = 'ForMatlab';
[numbers, strings] = xlsread(ExcelFilename,sheetName);
data = numbers;
%%
for i=1:length(data)
    temp1=sprintf('%2d & %6d & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f & %.2f \\\\',data(i,1),data(i,2),data(i,3),data(i,4),data(i,5),data(i,6),data(i,7),data(i,8),data(i,9)/1e13,data(i,10),data(i,11),data(i,12));
    disp(temp1)
end