function chess=add_chess(N)

ww1=ones(1,N);
for ii= 1:length(ww1)
    if mod(ii,2)==0
    ww1(ii)=-1;
    end
end

% ww1=[1 -1  1 -1  1 -1  1];
ww2=-ww1;

chess=[];
for i= 1:length(ww1)

    if mod(i,2)==0
    
        chess=[chess; ww2];
    else
        chess=[chess; ww1];
        
    end
    
end

end