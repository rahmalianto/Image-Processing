function  [result] = knn(img)

    n = 2;
            
    % img = rgb2gray(img);
    img = im2double(img);

    rSubplot=3;
    cSubplot=4;

    [r,c] = size(img);
    maxVal = max(max(img));
    minVal = min(min(img));
    range = (maxVal-minVal).*rand(1000,1) + minVal;
    centroid = [min(range), max(range)];
    result = zeros(r,c);

    plot = 3;
    while(true)
        countD1=0;
        countD2=0;
        sumD1=0;
        sumD2=0;
        for i=1:r
            for j=1:c
                d1 = abs(img(i,j)-centroid(1,1));
                d2 = abs(img(i,j)-centroid(1,2));
                if(d1 < d2) 
                    result(i,j) = 1;
                    sumD1 = sumD1 + img(i,j);
                    countD1 = countD1 + 1;
                else
                    result(i,j) = 0;
                    sumD2 = sumD2 + img(i,j);
                    countD2 = countD2 + 1;
                end
            end
        end
        newCentroid1=sumD1/countD1;
        newCentroid2=sumD2/countD2;
        error = abs(centroid(1,1)-newCentroid1)+abs(centroid(1,2)-newCentroid2)
        if ( error < 0.0001)
            break;
        end
        centroid = [newCentroid1, newCentroid2];
        plot=plot+1;
    end
end