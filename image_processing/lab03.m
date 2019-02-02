close all
clear all

blurred=normalize(imread('oko.png'));
sharp=normalize(imread('oko2.png'));

img_show(...
    blurred, strcat("Result: ", num2str(sharpness(blurred), "%.8f")),...
    sharp, strcat("Result: ", num2str(sharpness(sharp), "%.8f"))...
)

close all
clear all

function result = sharpness(img)
    angle = 315;
    distance = ceil(sqrt(2));
    a = round(cosd(angle)*distance);
    b = round(sind(angle)*distance);
    result = zeros(size(img, 1), size(img, 2));
    for i = 1:size(img, 1)
       for j = 1:size(img, 1)
           if (i+a) <= 0 || (j+b) <= 0 || (i+a) > size(img, 1) || (j+b) > size(img, 2)
               continue
           end
           x = img(i+a,j+b)+1;
           y = img(i,j)+1;
           result(x, y) = result(x, y) + 1;
       end   
    end
    mesh_show(img, result);
    waitforbuttonpress;
    result = sum(diag(result))/sum(sum(img(:)));
end

function img_show(img, img_text, raw_img, raw_img_text)
    figure(2);
    subplot(1, 2, 1);
    image(uint8(raw_img));
    title(raw_img_text);
    axis equal;
    subplot(1, 2, 2);
    image(uint8(img));
    title(img_text);
    axis equal;
end

function img_ = normalize(img)
    img_ = uint8(255 * mat2gray(img)) + 1;
end

function mesh_show(img, img_arr)
    figure(1);
    subplot(2, 1, 1);
    image(uint8(img));
    subplot(2, 1, 2);
    mesh(img_arr);
end
