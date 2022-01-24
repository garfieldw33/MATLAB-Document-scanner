function threshold = Otsu(in)    
maxGray = max(max(in));    
minGray = min(min(in));    
t = double(minGray:maxGray);    
[M,N] = size(in);     
for k = 1:length(t)    
    tk = t(1,k);  
    %pixels of foreground and background  
    iforeground = 0;  
    ibackground = 0;  
    %sum of gray value of foreground and background  
    foreground = 0;  
    background = 0;  
    for i = 1:M  
        for j = 1:N  
            tmp = in(i,j);  
            if(tmp >= tk)    
                iforeground = iforeground + 1;  
                foreground = foreground + double(tmp);  
            else    
                ibackground = ibackground + 1;  
                background = background + double(tmp);  
            end  
        end  
    end  
    w0 = iforeground / (M*N);  
    w1 = ibackground / (M*N);  
    u0 = foreground / iforeground;  
    u1 = background / ibackground;  
    t(2,k) = w0*w1*(u0-u1)*(u0-u1);  
end  
%maximum value of the variance in the second row, ignoring NaN 
omax = max(t(2,:));    
index = find(t(2,:) >= omax);    
t = t(1,index);  
threshold = t;
end