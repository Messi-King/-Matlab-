function zimu = guiyihua_muban_zimu;
             
%1-5 ABCDE 6-10FGHIJ 11-15 KLMNP 16-20 QRSTU 21-25 VWXYZ
zimu(:,:,1)   =imresize(im2bw(imread('10.bmp'),graythresh(rgb2gray(imread('10.bmp')))),[110 70],'bilinear');    %A
zimu(:,:,2)   =imresize(im2bw(imread('11.bmp'),graythresh(rgb2gray(imread('11.bmp')))),[110 70],'bilinear');    %B
zimu(:,:,3)   =imresize(im2bw(imread('12.bmp'),graythresh(rgb2gray(imread('12.bmp')))),[110 70],'bilinear');    %C
zimu(:,:,4)   =imresize(im2bw(imread('13.bmp'),graythresh(rgb2gray(imread('13.bmp')))),[110 70],'bilinear');    %D
zimu(:,:,5)   =imresize(im2bw(imread('14.bmp'),graythresh(rgb2gray(imread('14.bmp')))),[110 70],'bilinear');    %E
zimu(:,:,6)   =imresize(im2bw(imread('15.bmp'),graythresh(rgb2gray(imread('15.bmp')))),[110 70],'bilinear');    %F
zimu(:,:,7)   =imresize(im2bw(imread('16.bmp'),graythresh(rgb2gray(imread('16.bmp')))),[110 70],'bilinear');    %G
zimu(:,:,8)   =imresize(im2bw(imread('17.bmp'),graythresh(rgb2gray(imread('17.bmp')))),[110 70],'bilinear');    %H
zimu(:,:,9)   =imresize(im2bw(imread('18.bmp'),graythresh(rgb2gray(imread('18.bmp')))),[110 70],'bilinear');    %J
zimu(:,:,10)  =imresize(im2bw(imread('19.bmp'),graythresh(rgb2gray(imread('19.bmp')))),[110 70],'bilinear');    %K
zimu(:,:,11)  =imresize(im2bw(imread('20.bmp'),graythresh(rgb2gray(imread('20.bmp')))),[110 70],'bilinear');    %L
zimu(:,:,12)  =imresize(im2bw(imread('21.bmp'),graythresh(rgb2gray(imread('21.bmp')))),[110 70],'bilinear');    %M
zimu(:,:,13)  =imresize(im2bw(imread('22.bmp'),graythresh(rgb2gray(imread('22.bmp')))),[110 70],'bilinear');    %N
zimu(:,:,14)  =imresize(im2bw(imread('23.bmp'),graythresh(rgb2gray(imread('23.bmp')))),[110 70],'bilinear');    %P
zimu(:,:,15)  =imresize(im2bw(imread('24.bmp'),graythresh(rgb2gray(imread('24.bmp')))),[110 70],'bilinear');    %Q
zimu(:,:,16)  =imresize(im2bw(imread('25.bmp'),graythresh(rgb2gray(imread('25.bmp')))),[110 70],'bilinear');    %R
zimu(:,:,17)  =imresize(im2bw(imread('26.bmp'),graythresh(rgb2gray(imread('26.bmp')))),[110 70],'bilinear');    %S
zimu(:,:,18)  =imresize(im2bw(imread('27.bmp'),graythresh(rgb2gray(imread('27.bmp')))),[110 70],'bilinear');    %T
zimu(:,:,19)  =imresize(im2bw(imread('28.bmp'),graythresh(rgb2gray(imread('28.bmp')))),[110 70],'bilinear');    %U
zimu(:,:,20)  =imresize(im2bw(imread('29.bmp'),graythresh(rgb2gray(imread('29.bmp')))),[110 70],'bilinear');    %V
zimu(:,:,21)  =imresize(im2bw(imread('30.bmp'),graythresh(rgb2gray(imread('30.bmp')))),[110 70],'bilinear');    %W
zimu(:,:,22)  =imresize(im2bw(imread('31.bmp'),graythresh(rgb2gray(imread('31.bmp')))),[110 70],'bilinear');    %X
zimu(:,:,23)  =imresize(im2bw(imread('32.bmp'),graythresh(rgb2gray(imread('32.bmp')))),[110 70],'bilinear');    %Y
zimu(:,:,24)  =imresize(im2bw(imread('33.bmp'),graythresh(rgb2gray(imread('33.bmp')))),[110 70],'bilinear');    %Z

