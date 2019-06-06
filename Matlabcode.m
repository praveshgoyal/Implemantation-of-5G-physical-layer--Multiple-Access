clc;
clear all;
close all;
N=100000;
p1=16;
p2=4;
x1=randi([0,1],1,N);
x2=randi([0,1],1,N);
p=1;
for i=1:2:N
    if (x1(i)==0 && x1(i+1)==0)
        y1(p)=1+1i;
    elseif (x1(i)==0 && x1(i+1)==1)
        y1(p)=1-1i;
    elseif (x1(i)==1 && x1(i+1)==0)
         y1(p)=-1+1i;
    elseif (x1(i)==1 && x1(i+1)==1)
         y1(p)=-1-1i;
    end
    p=p+1;
end
p=1;
for i=1:2:N
    if (x2(i)==0 && x2(i+1)==0)
        y2(p)=1+1i;
    elseif (x2(i)==0 && x2(i+1)==1)
        y2(p)=1-1i;
    elseif (x2(i)==1 && x2(i+1)==0)
         y2(p)=-1+1i;
    elseif (x2(i)==1 && x2(i+1)==1)
         y2(p)=-1-1i;
    end
    p=p+1;
end
mi=p1*y1+(p2^2/p1)*y2;

noise=(randn([1,N/2])+1i*randn([1,N/2]));
h=(randn([1,N/2])+1i*randn([1,N/2]));

j=1;

for SNRdb=0:4:40;
    SNRlin=10^(SNRdb/10);
    sigma=1/sqrt(SNRlin);
    m1=h.*mi+sigma*noise;
    y=m1./h;
    m=1;
for i=1:N/2
    if (real(y(i))>0 && imag(y(i))>0)
        q1(m)=0;
        q1(m+1)=0;
    end
    if (real(y(i))>0 && imag(y(i))<0)
        q1(m)=0;
        q1(m+1)=1;
    end
    if (real(y(i))<0 && imag(y(i))>0)
         q1(m)=1;
         q1(m+1)=0;
    end
    if (real(y(i))<0 && imag(y(i))<0)
         q1(m)=1;
         q1(m+1)=1;
    end
    m=m+2;
end


z=modulation(q1);
fi=p1.*z;
z1=y-fi;

m=1;
for i=1:N/2
    if (real(z1(i))>0 && imag(z1(i))>0)
        q2(m)=0;
        q2(m+1)=0;
    end
    if (real(z1(i))>0 && imag(z1(i))<0)
        q2(m)=0;
        q2(m+1)=1;
    end
    if (real(z1(i))<0 && imag(z1(i))>0)
         q2(m)=1;
         q2(m+1)=0;
    end
    if (real(z1(i))<0 && imag(z1(i))<0)
         q2(m)=1;
         q2(m+1)=1;
    end
    m=m+2;
end

error1(j)=sum(q1~=x1);
ber_prac1(j)=error1(j)/N;
error2(j)=sum(q2~=x2);
ber_prac2(j)=error2(j)/N;
j=j+1;
end
SNRdb=0:4:40;
semilogy(SNRdb,ber_prac1,'o-');
hold on;
grid on;
semilogy(SNRdb,ber_prac2,'*-');
xlabel('SNRdB');
ylabel('BER');
legend('Ber of High power signal(P1=16 units)','Ber of Low power signal(P2=8 units)');
