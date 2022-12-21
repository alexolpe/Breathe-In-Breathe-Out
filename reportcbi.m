%{
import mlreportgen.dom.*
import mlreportgen.report.*
rpt = Report('exampleReport', 'pdf'); % Create an mlreportgen.report.Report object
% Create a sample image
im = Image(which('bibologo.jpg'));
im.Width = '1in';
im.Height = '0.75in';
% Construct the header
header = PDFPageHeader();
append(header, im);
% Get the report's page layout and set header
layout = getReportLayout(rpt);
layout.PageHeaders = header;

append(rpt,Heading1('Breathe in Breathe out test'));
p = Paragraph('');
add(rpt, p);
p = Paragraph('Sr/a.');
p.FontSize = '12pt';
add(rpt, p);

p = Paragraph('Francisco del Campo');
p.FontSize = '12pt';
add(rpt, p);

p = Paragraph('ID: XXXXXXXXX');
p.FontSize = '12pt';
add(rpt, p);

p = Paragraph('Birth date: DD-MM-YYYY');
p.FontSize = '12pt';
add(rpt, p);

p = Paragraph('Telephone: 0123456789');
p.FontSize = '12pt';
add(rpt, p);

append(rpt,Heading1('VOCs biomarkers detection:'));
p = Paragraph('');
add(rpt, p);

p = Paragraph('Analysis 2044      Date: 8-12-2022');
p.Bold = true;
p.FontSize = '12pt';
add(rpt, p);
p = Paragraph('');
add(rpt, p);
p = Paragraph('');
add(rpt, p);

p = Paragraph('2-butanone................................................452%     (50-250)');
p.Italic = true;
p.FontSize = '11pt';
add(rpt, p);
p = Paragraph(' ');
add(rpt, p);

p = Paragraph('2-methylhexane...........................................123ppm     (90-120)');
p.Italic = true;
p.FontSize = '11pt';
add(rpt, p);
p = Paragraph(' ');
add(rpt, p);

p = Paragraph('ethanol......................................................62ppm     (10-20)');
p.Italic = true;
p.FontSize = '11pt';
add(rpt, p);
p = Paragraph(' ');
add(rpt, p);

p = Paragraph('methane...................................................304ppm     (100-220)');
p.Italic = true;
p.FontSize = '11pt';
add(rpt, p);
p = Paragraph(' ');
add(rpt, p);

close(rpt);
rptview(rpt)
%}



%% Breathe in Breathe out
% Test result for:
format short g
x=inputdlg({'Name and Surnames','ID','Birth date','Telephone'},...
    'Personal Information', [1 35; 1 15; 1 15; 1 15]);

disp('Sr/a.')
disp(x{1})
disp(['ID: ',x{2}])
disp(['Birth date: ',x{3}])
disp(['Telephone: ',x{4}])

%% VOC's biomarkers detection:

percc=100.*rand(1,1);
perc=round(percc,2);
%mvec=medv;
mvec=maxv;
%mvec=[452,123,56,90];
max1=medv(1);
max2=medv(2);
max3=medv(3);
max4=medv(4);
llin1=20000;
llin2=500;
if mvec(3)>llin1
    perc='HIGH';
else
    perc='LOW';
end
disp(['Analysis ', '0001','      Date: 8/12/2022'])
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(['2-butanone.............................................',num2str(max1),'ppb'])
disp(' ')
disp(['2-methylhexane........................................',num2str(max2),'ppb'])
disp(' ')
disp(['ethanol..............................................',num2str(max3),'ppb'])
disp(' ')
disp(['methane..............................................',num2str(max4),'ppb'])
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(['It is estimated to have ',perc,' chances of developing lung cancer'])
disp(' ')
disp(' ')
disp('FOR MEDICAL PURPOSES ONLY')
%}