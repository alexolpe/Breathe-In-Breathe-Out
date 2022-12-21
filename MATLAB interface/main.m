function main
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
    elseif strcmp(recieved, "T6713")
        iagcorec=arr;
        arr=[];
        ii=3;
        n=0;
    elseif strcmp (recieved, "iaqcorec2")
        T6713=arr;
        arr=[];
        ii=4;
        n=0;
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
end