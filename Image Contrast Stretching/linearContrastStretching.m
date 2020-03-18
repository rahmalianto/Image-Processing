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


%min-max linear stretching
minMax1 = minMaxLinearStretching(img1);
minMax2 = minMaxLinearStretching(img2);
minMax3 = minMaxLinearStretching(img3);
    
figure(1),
subplot(r,c,3), imshow(minMax1), title('Min-Max Linear Stretching');
subplot(r,c,4), imhist(minMax1), title('Min-Max Linear Stretching');
figure(2),
subplot(r,c,3), imshow(minMax2), title('Min-Max Linear Stretching');
subplot(r,c,4), imhist(minMax2), title('Min-Max Linear Stretching');
figure(3),
subplot(r,c,3), imshow(minMax3), title('Min-Max Linear Stretching');
subplot(r,c,4), imhist(minMax3), title('Min-Max Linear Stretching');


%percentage linear stretching
percentage = 100;
percentage1 = percentageLinearStretching(img1,percentage);
percentage2 = percentageLinearStretching(img2,percentage);
percentage3 = percentageLinearStretching(img3,percentage);

figure(1),
subplot(r,c,5), imshow(percentage1), title('Percentage Linear Stretching');
subplot(r,c,6), imhist(percentage1), title('Percentage Linear Stretching');
figure(2),
subplot(r,c,5), imshow(percentage2), title('Percentage Linear Stretching');
subplot(r,c,6), imhist(percentage2), title('Percentage Linear Stretching');
figure(3),
subplot(r,c,5), imshow(percentage3), title('Percentage Linear Stretching');
subplot(r,c,6), imhist(percentage3), title('Percentage Linear Stretching');


%piecewiseLinearStretching
piecewiseLinearStretching(img1);
piecewiseLinearStretching(img2);
piecewiseLinearStretching(img3);