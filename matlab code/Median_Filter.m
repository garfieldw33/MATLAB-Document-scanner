function out = Median_Filter (in)
out=zeros(size(in));
for i= 2:size(in,1)-1
    for j=2:size(in,2)-1
        window=zeros(9,1);
        k=1;
        for x=1:3
            for y=1:3
                window(k)=in(i+x-2,j+y-2);
                k=k+1;
            end
        end
        med=sort(window);
        out(i,j)=med(5);     
    end
end
out=uint8(out);
end