%% Interface
clear all;

s=serialport('COM3',9600);% Change the serial port to 'COM3'                          % open the session                % read from the port 
n=0;
tl=20;
recieved="";
subplot(2,2,1)
plot(0,0)
subplot(2,2,2)
plot(0,0)
subplot(2,2,3)
plot(0,0)
subplot(2,2,4)
plot(0,0)
sgtitle('VOCs biomarkers detection') 

while ~strcmp (recieved, "finish") 
    strr=readline (s)
    recieved=strtrim(strr)
    if strcmp(recieved, "mq135")
        ii=1;
        n=0;
    elseif strcmp (recieved, "iaqcorec")
        mq135=arr;
        arr=[];
        ii=2;
        n=0;
        subplot(2,2,1)
    title('2-butanone') % change names for the final detected VOCs
    elseif strcmp(recieved, "T6713")
        iagcorec=arr;
        arr=[];
        ii=3;
        n=0;
         subplot(2,2,2) 
    title('2-methylhexane') 
    elseif strcmp (recieved, "SMUART04L")
        T6713=arr;
        arr=[];
        ii=4;
        n=0;
        subplot(2,2,3) 
    title('ethanol') 
    end
n=n+1;
arr (n) = str2double (recieved);
x=(tl/n).*[1:n];
subplot(2,2,ii)
    plot(x,arr,'-.k')
    xlabel('t[s]') % change x and y labels for the final plots
    ylabel('ppb')
    grid on
end
subplot(2,2,4) 
    title('methane')
    smuart041=arr;
    global maxv medv
    medv=[mean(mq135(2:end-1)) mean(iagcorec(2:end-1)) mean(T6713(2:end-1)) mean(smuart041(2:end-1))];
    maxv=[max(mq135(2:end-1)) max(iagcorec(2:end-1)) max(T6713(2:end-1)) max(smuart041(2:end-1))];



    %btn = uicontrol('Position',[20 20 80 35],'Fontsize',10,'BackgroundColor','w');
    %btn.String = 'Print Report';
    %btn.Callback = @plotButtonPushed;
    options.format = 'pdf';
    options.showCode = false;
    rpo=publish('reportcbi.m',options);
    open(rpo)

    %btn2 = uicontrol('Position',[600 20 80 35],'Fontsize',10,'BackgroundColor','w');
    %btn2.String = 'Restart test';
    %btn2.Callback = @reButtonPushed;

%{
for ii=1:4
    x=100.*rand(100,1); % change x and y for the plotable values
    x=sort(x);
    y=100.*rand(100,1);
    y=sort(y);
    subplot(2,2,ii)
    plot(x,y,'k')
    xlabel('t[s]') % change x and y labels for the final plots
    ylabel('[m]')
    grid on
end
sgtitle('VOCs biomarkers detection') 
subplot(2,2,1)
title('2-butanone') % change names for the final detected VOCs
subplot(2,2,2) 
title('2-methylhexane') 
subplot(2,2,3) 
title('ethanol') 
subplot(2,2,4) 
title('methane')

btn = uicontrol;
btn.String = 'Print Report';
btn.Callback = @plotButtonPushed;
%}
%{
legend('Aggregate error','Cv-error')
axis equal
hold off
%}