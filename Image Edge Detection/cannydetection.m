clear all;
clc;
close all;
     
% Get the initial image lena.gif
x=imread('img1.png');               
w=rgb2gray(x);
figure(1);colormap(gray);
subplot(3,2,1);
imagesc(w,200);
title('Image: lena.gif');

% X-axis direction edge detection
subplot(3,2,2);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(w,filterx,'same');
imagesc(Ix);
title('Ix');

% Y-axis direction edge detection
subplot(3,2,3)
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(w,filtery,'same'); 
imagesc(Iy);
title('Iy');

% Norm of the gradient (Combining the X and Y directional derivatives)
subplot(3,2,4);
NVI=sqrt(Ix.*Ix+Iy.*Iy);
imagesc(NVI);
title('Norm of Gradient');

% Thresholding
I_max=max(max(NVI));
I_min=min(min(NVI));
level=alfa*(I_max-I_min)+I_min;
subplot(3,2,5);
Ibw=max(NVI,level.*ones(size(NVI)));
imagesc(Ibw);
title('After Thresholding');

% Thinning (Using interpolation to find the pixels where the norms of 
% gradient are local maximum.)
subplot(3,2,6);
[n,m]=size(Ibw);
for i=2:n-1,
for j=2:m-1,
	if Ibw(i,j) > level,
	X=[-1,0,+1;-1,0,+1;-1,0,+1];
	Y=[-1,-1,-1;0,0,0;+1,+1,+1];
	Z=[Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
	   Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
	   Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
	XI=[Ix(i,j)/NVI(i,j), -Ix(i,j)/NVI(i,j)];
	YI=[Iy(i,j)/NVI(i,j), -Iy(i,j)/NVI(i,j)];
	ZI=interp2(X,Y,Z,XI,YI);
		if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
		I_temp(i,j)=I_max;
		else
		I_temp(i,j)=I_min;
		end
	else
	I_temp(i,j)=I_min;
	end
end
end
imagesc(I_temp);
title('After Thinning');
colormap(gray);
%%%%%%%%%%%%%% End of the main.m file %%%%%%%%%%%%%%%
