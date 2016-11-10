function [RMSE,Offset]=RMSEandOffset(xsim,ysim,xexp0,yexp0)
%     clc
%     xsim=Ra_Ti0A;
%     ysim=Ti0A;
%     xexp=Ra_Ti0C;
%     yexp=Ti0C;
    IndexGE0 = min(find(xexp0>=0));
    
    xexp = xexp0(IndexGE0:length(xexp0));
    yexp = yexp0(IndexGE0:length(xexp0));
    
    x=xsim;
    y=ysim;
    xq=xexp;
    yq=interp1(x,y,xq,'spline');
    yqmax=max(yq);
    
    RMSE = 0;
    Offset = 0;
    temp1 = 0;
    temp2 = 0;
    for i=1:length(xexp)
        temp1 = temp1 + ((yq(i)-yexp(i))/max(yexp))*((yq(i)-yexp(i))/max(yexp));
        temp2 = temp2 + (yq(i)-yexp(i))/(max(yexp));
    end
    
    RMSE = sqrt(temp1/length(xexp))*100;
    Offset = temp2/length(xexp)*100;
    
    figure();
    plot(x,y,'-rs',xq,yq,'go',xexp,yexp,'bs');
    legend('sim','spline','exp');
    

%     RMSE
%     Offset
end