function  [r] = percentageLinearStretching(img,percentage)
    meanVal = mean(img(:))
    lower = 0;  %a
    upper = 255;  %b
    range = upper - lower;
    distanceFromMean = (meanVal*percentage/100)/2;
    minVal = meanVal - distanceFromMean %c
    maxVal = meanVal + distanceFromMean %d
    r = ((img-minVal)*((upper-lower)/(maxVal-minVal)))+lower;
end