function buttonPlot
% Create a figure window
fig = uifigure('Name','Plotted Results');
%sgtitle('VOCs biomarkers detection') 
% Create a UI axes
ax1 = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [50, 30, 180, 180]);
ax2 = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [50, 220, 180, 180]);
ax3 = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [260, 30, 180, 180]);
ax4 = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [260, 220, 180, 180]);
ax=[ax1,ax2,ax3,ax4];

for ii=1:4
    x=100.*rand(100,1); % change x and y for the plotable values
    x=sort(x);
    y=100.*rand(100,1);
    y=sort(y);
    plot(ax(ii),x,y,'k')
    hold on
    title('2-butanone') % change names for the final detected VOCs
    xlabel('t[s]') % change x and y labels for the final plots
    ylabel('[m]')
    grid on
end


% Create a push button
btn = uibutton(fig,'push',...
               'Position',[470, 200, 70, 20],...
               'Text', 'REPORT',...
               'ButtonPushedFcn', @(btn,event) plotButtonPushed(btn,ax1));

end


% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(btn,ax1)
    
options.format = 'pdf';
options.showCode = false;
rpo=publish('reportcbi.m',options);
open(rpo)
end