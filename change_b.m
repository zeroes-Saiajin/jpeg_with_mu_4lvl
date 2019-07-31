function walsh_Mersene=change_b(Hadamar_Mersene)



[n,n]=size(Hadamar_Mersene); 
p=n+1;
a=1
b1=a*(p-sqrt(4*p))/(p-4)
b=b1

for i=1:n
    for j=1:n
        if Hadamar_Mersene(i,j)==-1
            walsh_Mersene(i,j)=-b;
        else
            walsh_Mersene(i,j)=1;
            
        end
    end
end
