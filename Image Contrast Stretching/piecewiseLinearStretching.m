function  [r] = piecewiseLinearStretching(img)
    r=3;
    c=2;
    figure,
    subplot(r,c,1), imshow(img), title('Original Image');
    subplot(r,c,2), imhist(img), title('Original Image');
    
    x=0:255;
    % breaking points from gui
%     x1 =input('Enter any value for 1st break point(X1):');
    x1 = 100;
    x2 = 150;
    y1 = 50;
    y2 = 200;

    % range definitions
    x_r1 = 0:x1;
    x_r2 = x1+1:x2;
    x_r3 = x2+1:255;

    % line gradients
    a1 = y1/x1;
    a2 = (y2-y1)/(x2-x1);
    a3 = (255-y2)/(255-x2);

    % line functions
    yo_1 = a1*x_r1;
    yo_2 = y1 + (a2*(x_r2-x1));
    yo_3 = y2 + (a3*(x_r3-x2));

    % line concatance
    y = [yo_1 yo_2 yo_3];

    % plot line
    subplot(r,c,4), plot(x,y), title('Piecewise Function'), grid on;
    xlim([0 255]);
    ylim([0 255]);

    % Implementing contrast stretching using piece wise linear transform.
    [rowi coli]=size(img);
    out=zeros(rowi,coli);

    for k=1:256
        for i=1:rowi
            for j=1:coli
                if img(i,j)==x(k) 
                    out(i,j)=y(k);
                end
            end
        end
    end
    subplot(r,c,5), imshow(uint8(out)), title('Piecewise Streching');
    subplot(r,c,6), imhist(uint8(out)), title('Piecewise Streching');
end