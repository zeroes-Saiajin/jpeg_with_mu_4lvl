clear all 
close all
clc 


%Первый этап - подключение изображения
I0=imread('dog.bmp');
I=double(I0);
%Размер блоков матриц,с которыми мы будем работать
m = 4
n = 4.^m - 1

proc = 0.8

%Второй этап - Создание Матрицы Мерсенна-Уолша
T = Walsh_MERS(n)


%Проверка на квазиортогональность
Proverka4 = T*T'
figure()
imagesc(Proverka4)
colormap(gray(2))
title('T*T"')


%Работа с изображением
R=I(:,:,1)
G=I(:,:,2)
B=I(:,:,3)
figure()
imshow(uint8(R))
title('исходное изображение')


%Умножение ММУ на блоки матрицы изображения n-размера
R1 = blkproc(R,[n n],'P1*x*P2',T,T');
G1 = blkproc(G,[n n],'P1*x*P2',T,T');
B1 = blkproc(B,[n n],'P1*x*P2',T,T');
figure()
imshow(uint8(B1))
title('4-x')

%Размер изображения
[x, y] = size(B1);

%Уменьшение яркости
R2 = R1./(Proverka4(2,2));
G2 = G1./(Proverka4(2,2));
B2 = B1./(Proverka4(2,2));
figure()
imshow(uint8(B))
title('разбиение на блоки - 4')

      
%Сжатие изображения
mask = ad_mask_fun(n, proc) %Маска для изображения


R3 = blkproc(R2,[n n],'P1.*x',mask);
G3 = blkproc(G2,[n n],'P1.*x',mask);
B3 = blkproc(B2,[n n],'P1.*x',mask);
figure()
imshow(uint8(B3))
title('наложение маски - 4')




%Зигзаг проход при помощи матрицы индексов
%ind = reshape(1:numel(B3), size(B3));       % indices of elements
%ind = fliplr( spdiags( fliplr(ind) ) );     % get the anti-diagonals
%ind(:,1:2:end) = flipud( ind(:,1:2:end) );  % reverse order of odd columns
%ind(ind==0) = []; 


%rle кодирование и декодирование

%rr = rle(B3(ind))
%rrr = rle(rr)

%Возврат изображения
%Final = invzigzag(rrr, x, y)


%Финальное декодирование изображения при помощи ММУ
F1 = blkproc(R3,[n n],'P1*x*P2',T,T')
F2 = blkproc(G3,[n n],'P1*x*P2',T,T')
F3 = blkproc(B3,[n n],'P1*x*P2',T,T')

RR1 = F1./(Proverka4(2,2))
GG1 = F2./(Proverka4(2,2))
BB1 = F3./(Proverka4(2,2))

%figure()
%imshow(uint8(I3))
%title('востановленное изображение 4')
%imwrite(uint8(I3),'proverka2.bmp')
rgbimg=cat(3,RR1,GG1,BB1)
figure()
imshow(uint8(rgbimg))
