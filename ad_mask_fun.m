function mask=ad_mask_fun(N, proc)
%proc - ���������� �� 0 �� 1,������� ����� ������� ��������� �������


mask=[];
leight = N*N

mask = ones(1, leight)

procent = ceil(leight * proc)

mask(1,1:procent) = 0

mask = invzigzag(mask,N,N)
         