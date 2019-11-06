function [ Qpsk ] = modulation( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
i=1;
n=length(x);
for k=1:n/2
    if x(i)==0 && x(i+1)==0
        Qpsk(k)=1+1j;
    elseif x(i)==0 && x(i+1)==1
        Qpsk(k)=1-1j;
    elseif x(i)==1 && x(i+1)==0
        Qpsk(k)=-1+1j;
    elseif x(i)==1 && x(i+1)==1
        Qpsk(k)=-1-1j;    
    end
    i=i+2;
end

end

