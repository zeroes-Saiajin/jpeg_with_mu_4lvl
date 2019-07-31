clear all 
close all
clc 


%Первый этап - подключение изображения
I0=imread('initiald.png');
I=double(I0);
%Размер блоков матриц,с которыми мы будем работать
n = 35
proc = 0.5

%Второй этап - Создание Матрицы Мерсенна-Уолша
T = Walsh_MERS(n)


%Проверка на квазиортогональность
Proverka4 = T*T'
figure()
imagesc(Proverka4)
colormap(gray(2))
title('T*T"')


%Работа с изображением
I=I(:,:,1)
figure()
imshow(uint8(I))
title('исходное изображение')



%Умножение ММУ на блоки матрицы изображения n-размера
B1 = blkproc(I,[n n],'P1*x*P2',T,T');
figure()
imshow(uint8(B1))
title('4-x')

%Размер изображения
[x, y] = size(B1);

%Уменьшение яркости
B = B1./(Proverka4(2,2));
figure()
imshow(uint8(B))
title('разбиение на блоки - 4')

      
%Сжатие изображения
mask = ad_mask_fun(n, proc) %Маска для изображения


B3 = blkproc(B,[n n],'P1.*x',mask);
figure()
imshow(uint8(B3))
title('наложение маски - 4')




%Зигзаг проход при помощи матрицы индексов
ind = reshape(1:numel(B3), size(B3));       % indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );     % get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );  % reverse order of odd columns
ind(ind==0) = []; 


%rle кодирование и декодирование

rr = rle(B3(ind))
rrr = rle(rr)

%Возврат изображения
Final = invzigzag(rrr, x, y)


%Финальное декодирование изображения при помощи ММУ
I2 = blkproc(Final,[n n],'P1*x*P2',T,T')
I3 = I2./(Proverka4(2,2))
figure()
imshow(uint8(I3))
title('востановленное изображение 4')

imwrite(uint8(I3),'proverka.jpg')

%Метрика изображения
%MSE = immse(I,I3)

%[peaksnr, snr] = psnr(I,I3)
%[ssimval, ssimmap] = ssim(I,I3)

%fprintf('\n The mean-squared error  is %0.4f \n', MSE);
%fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%fprintf('\n The SNR value is %0.4f \n', snr);
%fprintf('\n The Structural Similarity   is %0.4f \n', ssimval);