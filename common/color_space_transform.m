function frame = color_space_transform(im_rgb, cs)

    switch lower(cs)
        case 'gray'
            frame = rgb2gray(im_rgb);
        case 'rgb'
            frame = im_rgb;
        case 'hsv'
            frame = rgb2hsv(im_rgb);
        case 'ycbcr'
            frame = rgb2ycbcr(im_rgb);
        case 'rgb+hsv'
            frame_hsv = im2double(rgb2hsv(im_rgb));
            frame = im2double(im_rgb);
            frame(:,:,4:6) = frame_hsv;
        case 'hsv+ycbcr'
            frame_hsv = im2double(rgb2hsv(im_rgb));
            frame_ycbcr = im2double(rgb2ycbcr(im_rgb));
            frame(:,:,1:3) = frame_hsv;
            frame(:,:,4:6) = frame_ycbcr;
        case 'rgb+ycbcr'
            frame = im2double(im_rgb);
            frame_ycbcr = im2double(rgb2ycbcr(im_rgb));
            frame(:,:,4:6) = frame_ycbcr;
        case 'rgb+hsv+ycbcr'
            frame = im2double(im_rgb);
            frame_hsv = im2double(rgb2hsv(im_rgb));
            frame_ycbcr = im2double(rgb2ycbcr(im_rgb));
            frame(:,:,4:6) = frame_hsv;
            frame(:,:,7:9) = frame_ycbcr;
        otherwise
            error('Wrong color space format');
    end
end