clear all 
close all
clc 


%������ ���� - ����������� �����������
I0=imread('dog.bmp');
I=double(I0);
%������ ������ ������,� �������� �� ����� ��������
m = 4
n = 4.^m - 1

proc = 0.8

%������ ���� - �������� ������� ��������-�����
T = Walsh_MERS(n)


%�������� �� ��������������������
Proverka4 = T*T'
figure()
imagesc(Proverka4)
colormap(gray(2))
title('T*T"')


%������ � ������������
I=I(:,:,1)
figure()
imshow(uint8(I))
title('�������� �����������')


%��������� ��� �� ����� ������� ����������� n-�������
B1 = blkproc(I,[n n],'P1*x*P2',T,T');
figure()
imshow(uint8(B1))
title('4-x')

%������ �����������
[x, y] = size(B1);

%���������� �������
B = B1./(Proverka4(2,2));
figure()
imshow(uint8(B))
title('��������� �� ����� - 4')

      
%������ �����������
mask = ad_mask_fun(n, proc) %����� ��� �����������


B3 = blkproc(B,[n n],'P1.*x',mask);
figure()
imshow(uint8(B3))
title('��������� ����� - 4')




%������ ������ ��� ������ ������� ��������
ind = reshape(1:numel(B3), size(B3));       % indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );     % get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );  % reverse order of odd columns
ind(ind==0) = []; 


%rle ����������� � �������������

rr = rle(B3(ind))
rrr = rle(rr)

%������� �����������
Final = invzigzag(rrr, x, y)


%��������� ������������� ����������� ��� ������ ���
I2 = blkproc(Final,[n n],'P1*x*P2',T,T')
I3 = I2./(Proverka4(2,2))
figure()
imshow(uint8(I3))
title('�������������� ����������� 4')
imwrite(uint8(I3),'proverka2.bmp')


