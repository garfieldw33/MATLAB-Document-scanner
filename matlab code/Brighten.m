function out = Brighten(in)
[M,N]=size(in);
out=in;
for i=1:M
	for j=1:N
		out(i,j)=in(i,j)+25;
	end
end
end