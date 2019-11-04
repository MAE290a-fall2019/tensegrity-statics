%connectivity matrix

function C=connectivity(in, out, size)

C=zeros(1,size);

C(1,in + 1)=-1;

C(1,out + 1)=1;

return