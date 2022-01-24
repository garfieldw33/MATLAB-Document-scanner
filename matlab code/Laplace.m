function out= Laplace(I)
I=double(I);
[M,N]=size(I);
B=zeros(size(I));
w=1;    % parameter w
for x=2:M-1
    for y=2:N-1
B(x,y)=w*(I(x+1,y)+I(x-1,y)+I(x,y+1)+I(x,y-1)-4*I(x,y));    % apply Laplace filter
    end 
end
I=uint8(I);
B=uint8(B);
out=I-B;
end
