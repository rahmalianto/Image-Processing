close all;
clear all;
clc;

img = imread('img3.jpg');
% img = rgb2gray(img);

[r,c] = size(img);
imgSize = numel(img);
newImg = img;
histArray = zeros(1,256);
histArray2 = histArray;
pmf = histArray;
CDF = histArray;
newCDF = histArray;

for i = 0:255
    histArray(1,i+1) = sum(img(:)==i);
    pmf(1,i+1) = histArray(1,i+1)/imgSize;
    if i==0
        CDF(1,1) = pmf(1,1);
    elseif i>0
        CDF(1,i+1) = CDF(1,i)+pmf(1,i+1);
    end
    newCDF(1,i+1) = floor(CDF(1,i+1)*256);
end

for i=1:r
    for j=1:c
        newImg(i,j) = newCDF(1,img(i,j));
    end
end
for i = 0:255
    histArray2(1,i+1) = sum(newImg(:)==i);
end

rSubplot=2;
cSubplot=3;
figure, 
subplot(rSubplot,cSubplot,1), imshow(img), title('original image');
subplot(rSubplot,cSubplot,2), imhist(img), title('histogram -imhist');
subplot(rSubplot,cSubplot,3), bar(histArray), title('manual histogram');
subplot(rSubplot,cSubplot,4), bar(pmf), title('Probability Mass Function');
subplot(rSubplot,cSubplot,5), plot(CDF), title('Cumulative Distribution Function');
subplot(rSubplot,cSubplot,6), plot(newCDF), title('New Cumulative Distribution Function');

figure,
subplot(2,2,1), imshow(img), title('original image');
subplot(2,2,2), imshow(newImg), title('histogram equalization');
subplot(2,2,3), imhist(img);
subplot(2,2,4), imhist(newImg);