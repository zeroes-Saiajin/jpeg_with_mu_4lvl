function T4 = Walsh_MERS(number)

N_mers=number;

N=N_mers+1;
hadamardMatrix  = hadamard(N);  

figure()
imagesc(((hadamardMatrix)))
colormap(gray(2))

HadIdx = 0:N-1;                         
M = log2(N)+1;      

binHadIdx = fliplr(dec2bin(HadIdx,M))-'0'; 
binSeqIdx = zeros(N,M-1);                  
for k = M:-1:2
   
    binSeqIdx(:,k) = xor(binHadIdx(:,k),binHadIdx(:,k-1));
end
SeqIdx = binSeqIdx*pow2((M-1:-1:0)');    
walshMatrix = hadamardMatrix(SeqIdx+1,:); 

figure()
imagesc(((walshMatrix)))
colormap(gray(2))

walshMatrix_MERS2=-walshMatrix(2:end,2:end);

figure()
imagesc(((walshMatrix_MERS2)))
colormap(gray(2))
title('2-� ��������� ������� ��������-�����');

walshMatrix_MERS=change_b(walshMatrix_MERS2);



%�������������� 2-� ��������� ������� � 4-� ������������ ��� ������
%������� ���������� ������� �� ���������� 1 � -1
chess=add_chess(N_mers);


T4=walshMatrix_MERS.*chess;
figure()
imagesc(T4)
title('4-� ��������� ������� ��������-�����');


figure()
imagesc(walshMatrix_MERS*walshMatrix_MERS')
colormap(gray(2)) 
 


