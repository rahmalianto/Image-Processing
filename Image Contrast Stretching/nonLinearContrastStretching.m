close all;
clear all;
clc;
format longE;

img1 = imread('img1.jpg');
img1 = rgb2gray(img1);
img2 = imread('img2.jpg');
img2 = rgb2gray(img2);
img3 = imread('img3.jpg');
% img3 = rgb2gray(img3);

r=3;
c=2;

%Original Image
figure(1),
subplot(r,c,1), imshow(img1), title('Original Image');
subplot(r,c,2), imhist(img1), title('Original Image');
figure(2),
subplot(r,c,1), imshow(img2), title('Original Image');
subplot(r,c,2), imhist(img2), title('Original Image');
figure(3),
subplot(r,c,1), imshow(img3), title('Original Image');
subplot(r,c,2), imhist(img3), title('Original Image');

%Histogram Equalization stretching
adapthisteq1 = histeq(img1);
adapthisteq2 = histeq(img2);
adapthisteq3 = histeq(img3);
    
figure(1),
subplot(r,c,3), imshow(adapthisteq1), title('Histogram Equalization');
subplot(r,c,4), imhist(adapthisteq1), title('Histogram Equalization');
figure(2),
subplot(r,c,3), imshow(adapthisteq2), title('Histogram Equalization');
subplot(r,c,4), imhist(adapthisteq2), title('Histogram Equalization');
figure(3),
subplot(r,c,3), imshow(adapthisteq3), title('Histogram Equalization');
subplot(r,c,4), imhist(adapthisteq3), title('Histogram Equalization');


%Adaptive Histogram equalization stretching
adapthisteq1 = adapthisteq(img1);
adapthisteq2 = adapthisteq(img2);
adapthisteq3 = adapthisteq(img3);
    
figure(1),
subplot(r,c,5), imshow(adapthisteq1), title('Adaptive Histogram Equalization');
subplot(r,c,6), imhist(adapthisteq1), title('Adaptive Histogram Equalization');
figure(2),
subplot(r,c,5), imshow(adapthisteq2), title('Adaptive Histogram Equalization');
subplot(r,c,6), imhist(adapthisteq2), title('Adaptive Histogram Equalization');
figure(3),
subplot(r,c,5), imshow(adapthisteq3), title('Adaptive Histogram Equalization');
subplot(r,c,6), imhist(adapthisteq3), title('Adaptive Histogram Equalization');
