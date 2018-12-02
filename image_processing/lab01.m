close all
clear all

img = imread('kierowca.png');
disp('Click on an image to see next effect')

img_analyse(img, img);

disp('addition - increase brightness, decrease contrast')
img_analyse(img + 60, img);

disp('substract - decrease brightness, decrease contrast')
img_analyse(img - 60, img);

disp('over 1 multiply - increase brightness, increase contrast')
img_analyse(img * 1.5, img);

disp('less than 1 multiply - decrease brightness, decrease contrast')
img_analyse(img * 0.5, img);

disp('exponentiation - increase brightness, increase contrast')
img_analyse(double(img) .^ 1.2, img);

disp('rooting - decrease brightness, decrease contrast')
img_analyse(double(img) .^ 0.8, img);

disp('logarythm - drastically decrease brightness, decrease contrast')
img_analyse(log(double(img)), img);

close all
disp('Thank you')



function img_analyse(img, raw_img)
    img_params(img, raw_img);
    img_show(img, raw_img);
    waitforbuttonpress;
end

function img_show(img, raw_img)
    figure(1);
    subplot(1, 2, 1);
    image(uint8(raw_img));
    axis equal;
    subplot(1, 2, 2);
    image(uint8(img));
    axis equal;
end

function img_params(img, raw_img)
    im_mean = mean2(img);
    im_mean_delta = im_mean - mean2(raw_img);
    
    im_median = median(img(:));
    im_median_delta = im_median - median(raw_img(:));
    
    im_std = std2(img);
    im_std_delta = im_std - std2(raw_img);
    
    im_r = max(max(img(:))) - min(min(img(:)));
    im_r_delta = im_r - (max(max(raw_img(:))) - min(min(raw_img(:))));
    
    disp("===================");
    disp("[brightness]");
    disp(['mean: ', num2str(im_mean), ' (delta: ', num2str(im_mean_delta), ')']);
    disp(['median: ', num2str(im_median), ' (delta: ', num2str(im_median_delta), ')']);
    
    disp("[contrast]");
    disp(['std: ', num2str(im_std), ' (delta: ', num2str(im_std_delta), ')']);
    disp(['R: ', num2str(im_r), ' (delta: ', num2str(im_r_delta), ')']);
    disp("===================");
end  