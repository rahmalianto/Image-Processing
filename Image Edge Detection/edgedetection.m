close all;
clear all;
clc;

img = imread('img1.png');
% img = rgb2gray(img);

result = img;
C=double(img);

for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
      
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        result(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end


rSubplot=1;
cSubplot=2;
figure, 
subplot(rSubplot,cSubplot,1), imshow(img), title('original image');
subplot(rSubplot,cSubplot,2), imshow(result), title('sobel');