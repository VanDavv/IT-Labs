close all
clear all

img = normalize(imread('kierowca.png'));
disp('Click on an image to see next effect');


img_analyse(img, img);

disp('linear a > 1 && b = 0; histogram strech right');
img_analyse(img .* 1.5, img);

disp('linear a < 1 && b = 0; histogram compress left');
img_analyse(img .* 0.5, img, 0);

disp('linear a = 1 && b > 0; move histogram right');
img_analyse(img + 50, img);

disp('linear a = 1 && b < 0; move histogram left');
img_analyse(img - 50, img);

disp('nonlinear x^2; histogram strech left');
img_analyse(double(img) .^ 2, img);

disp('nonlinear sqrt(x); histogram compress right');
img_analyse(double(img) .^ 0.5, img);

disp('nonlinear sqrt(x); histogram compress right');
img_analyse(log(double(img)), img);

% linear: (a>0; b=0) (a<0; b=0) (a=1; b>0) (a=1; b<0)
% normalization with non linear y2 = 255 * (y - min(y)) / (max(y) - min(y))
% grayImage = uint8(255 * mat2gray(originalImage));
% instead last one x^a; a = 1 neutral; a > 1 ? ; a < 1

function img_analyse(img, raw_img, need_norm)
    if ~exist('need_norm','var'), need_norm=1; end
    if need_norm == 1
        img = normalize(img);
    end
    img_params(img, raw_img);
    img_show(img, raw_img);
    waitforbuttonpress;
end

function img_ = normalize(img)
    img_ = uint8(255 * mat2gray(img)) + 1;
end

function img_show(img, raw_img)
    figure(1);
    subplot(2, 2, 1);
    image(uint8(raw_img));
    axis equal;
    subplot(2, 2, 2);
    image(uint8(img));
    axis equal;
    
    hist_1 = img_hist(raw_img);
    hist_2 = img_hist(img);
    max_x = max([size(img, 1), size(raw_img, 1)]);
    max_y = max([max(hist_1(:)), max(hist_2(:))]);
    subplot(2, 2, 3);
    plot(hist_1);
    xlim([0, max_x]);
    ylim([0, max_y]);
    subplot(2, 2, 4);
    plot(hist_2);
    xlim([0, max_x]);
    ylim([0, max_y]);
end

function result = img_hist(img)
    img_ = uint8(img);
    [x, y] = size(img_);
    result = zeros(1, max(img(:)));
    for i=1:x
        for j=1:y
            value = img_(i,j);
            result(value) = result(value) + 1;
        end
    end
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