clear;
close all;
clc;

I1=rgb2gray(imread('filetoscan.jpeg'));
I1wrap=PerspectiveWrap(I1,'StdPaper');

I2=rgb2gray(imread('cardtoscan.jpeg'));
I2wrap=PerspectiveWrap(I2,'Card');

I3=rgb2gray(imread('passporttoscan.jpeg'));
I3wrap=PerspectiveWrap(I3,'Passport');

figure;
imshow(I1wrap);
figure;
imshow(I2wrap);
figure;
imshow(I3wrap);

imwrite(I1wrap,'filewrapped.jpeg');
imwrite(I2wrap,'cardwrapped.jpeg');
imwrite(I3wrap,'passportwrapped.jpeg');

I1=rgb2gray(imread('prob1.PNG'));
I1wrap=PerspectiveWrap(I1,'Passport');

