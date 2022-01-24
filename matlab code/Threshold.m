function out = Threshold(in, th)
    [row, col]=size(in);
    out=in;
    for i=1:row
        for j=1:col
            if in(i,j)<=th
                out(i,j)=0;
            else
                out(i,j)=255;
            end
        end
    end
    out=uint8(out);
    out = imgaussfilt(out,0.4);
end