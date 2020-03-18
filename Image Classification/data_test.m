close all;
clear all;
clc;

data_luas = load('data_luas.mat');
data_entropy = load('data_entropy.mat');

img = imread('limaratus2.JPG');
img = rgb2gray(img);
img_bw = im2bw(img);
img_bw = minMaxLinearStretching(img_bw);
BW = imfill(img_bw, 'holes');

[B,L,N,A] = bwboundaries(BW);
figure, imshow(img);
hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B)
        boundary = B{k};
        cidx = mod(k,length(colors))+1;
        plot(boundary(:,2), boundary(:,1),colors(cidx),'LineWidth',2);
        %randomize text position for better visibility
        rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
        col = boundary(rndRow,2); row = boundary(rndRow,1);
        h = text(col+1, row-1, num2str(L(row,col)));
        set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end

%Luas
vektor = zeros(length(B),3);
[Y, num] = bwlabel(BW);
RGB = label2rgb(Y);
hold on
luas2 = zeros(length(B),1);
for k = 1:num
        [r, c] = find(bwlabel(BW)==k);
        h1 = text(c(1), r(1), num2str(k));
        set(h1,'Color',[0 0 0],'FontSize',14,'FontWeight','bold');
        vektor(k,1) = length(r);
        luas2 = length(r)
end
hold off

%entropy - tekstur
baru = zeros(size(img));
entr = zeros(length(B),1);
for m = 1:num
    [r, c] = find(bwlabel(BW)==m);
    t = max(r);
    t2 = min(r);
    tpanjang = t - t2;
    u = max(c);
    u2 = min(c);
    upanjang = u - u2;
    I = zeros(size(img));
    for indeks = 1 : length(r)
        baru(r(indeks),c(indeks),:) = img(r(indeks),c(indeks),:);
        I(r(indeks),c(indeks),:) = img(r(indeks),c(indeks),:);
    end
    J = entropy(I);
    entr = J
end
baru = uint8(baru);

% Devides objects and resizes them
for i=1:num
    i
    [r,c] = find(L==i);   
    len=max(r)-min(r)+2;
    width=max(c)-min(c)+2;
    obj=uint8(zeros([len width]));
    sy=min(c)-1;
    sx=min(r)-1;

    for j=1:size(r,1)
        x=r(j,1)-sx;
        y=c(j,1)-sy;
        obj(x,y)=img(r(j,1),c(j,1));
    end

    img_cropped = imresize(obj,[100 100]);
    figure, 
    subplot(1,3,1), imshow(img_cropped);
    img_cropped = histeq(img_cropped);
    subplot(1,3,2), imshow(img_cropped);
    img_sobel = edgeDetection(img_cropped);
    subplot(1,3,3), imshow(img_sobel);
%         img_filled = imfill(img_sobel,'holes');
%         subplot(2,3,4), imshow(img_filled);
%         img_knn = knn(img_filled);
%         subplot(2,3,5), imshow(img_knn);


    [B2,L2,N2,A2] = bwboundaries(img_sobel);
    hold on;
    colors=['b' 'g' 'r' 'c' 'm' 'y'];
    for k=1:length(B2)
            boundary = B2{k};
            cidx = mod(k,length(colors))+1;
            plot(boundary(:,2), boundary(:,1),colors(cidx),'LineWidth',2);
            %randomize text position for better visibility
            rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
            col = boundary(rndRow,2); row = boundary(rndRow,1);
            h = text(col+1, row-1, num2str(L2(row,col)));
            set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
    end
end

if luas2 > 1640 && entr > 0.9119
    type = '500';
elseif luas2 <= 1640 && luas2 > 1384 && entr <= 0.09119 && entr > 0.7932
    type = '200';
else
    type = '500';
end

figure, imshow(img);
caption = sprintf('Shapes #%d is a %s.', ...
    i, type);
title(caption, 'FontSize', 10);

