function plotButtonPushed(src,event)
    
options.format = 'pdf';
options.showCode = false;
rpo=publish('reportcbi.m',options);
open(rpo)
end