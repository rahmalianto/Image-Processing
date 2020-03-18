function  [r] = minMaxLinearStretching(img)
    format long;
    lower = 0;  %a
    upper = 255;  %b
    minVal = min(img(:)) %c
    maxVal = max(img(:)) %d
    r = ((img-minVal)*((upper-lower)/(maxVal-minVal)))+lower;
end