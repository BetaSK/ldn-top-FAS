function hout = Extract_LDN_TOP_from_Plane(im,options,plane)

im = double(im);
[height,width,channels] = size(im);
hout = [];

if strcmp(plane,'XY')
    hsize = options.blockSize_xy(1);
    wsize = options.blockSize_xy(2);
    h_overlap = options.overlap_xy(1);
    w_overlap = options.overlap_xy(2);
else
    hsize = height;
    wsize = width;
    h_overlap = 0;
    w_overlap = 0;
end

ldnParam = options.sigma;
nx = (height - h_overlap)/(hsize - h_overlap);
ny = (width - w_overlap)/(wsize - w_overlap);

bins = 56;

for c = 1:channels
    for sig = 1:length(ldnParam)
        sigma = ldnParam(sig);
        LDN_Image = ldn(im(:,:,c),'mask','gaussian','sigma',sigma);
        for i = 1:nx
            x = 1 + (i-1)*(hsize-h_overlap);
            for j = 1:ny
                y = 1 + (j-1)*(wsize-w_overlap);
                hout = [hout,ldn_hist(LDN_Image(x:x+hsize-1, y:y+wsize-1), bins)];
            end
        end
    end
end

end


function h = ldn_hist(im, bins)

    h = zeros(1,bins);
    [height,width] = size(im);
    table = zeros(1,64);
    ind = 1;
    for i = 1:8
        for j = 1:8
            num = (i-1)*8+(j-1);
            if i~=j
                table(num)=ind;
                ind = ind +1;
            end
        end
    end
    for i = 1:height
        for j = 1:width
            n = im(i,j);
            target = table(n);
            h(target) = h(target)+1;
        end
    end
    h = h/sum(h);
end
        
        
