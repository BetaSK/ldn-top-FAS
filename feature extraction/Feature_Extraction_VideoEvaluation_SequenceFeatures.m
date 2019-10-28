function F = Feature_Extraction_VideoEvaluation_SequenceFeatures(V,options)

    xc = floor(options.imageSize(1)/2);
    yc = floor(options.imageSize(2)/2);
    tc = floor(options.numFrame/2);
    
    ind = 1;

    % initialize three orthogonal planes in RGB color space
    XY = zeros(options.imageSize(1),options.imageSize(2),3); 

    frames = cell(1,options.numFrame);

    isdetected = 0;
    isFacelocDetermined = 0;
    faceloc2 = [];
    for t = 1:V.Duration*V.FrameRate

        % time truncation to avoid exception of reading
        if V.CurrentTime > (t-1)/V.FrameRate
            V.CurrentTime = (t-1)/V.FrameRate;
        end

        if hasFrame(V)
            frame = readFrame(V);
            if ~isdetected  
                faceloc1 = getBoundingBox(options, frame); % Detect faces
                if isempty(faceloc1)
                    continue;
                end
                isdetected = 1;
            end
            frames{ind} = frame;

            % generate XY plane
            if ind >= tc && ~isFacelocDetermined
                faceloc2 = getBoundingBox(options, frame); % Detect faces for XY plane
                if ~isempty(faceloc2)
                    frame_crop = frame(faceloc2(1,2):(faceloc2(1,2)+faceloc2(1,4)), faceloc2(1,1):(faceloc2(1,1)+faceloc2(1,3)),:);
                    XY = imresize(frame_crop, options.imageSize);
                    isFacelocDetermined = 1;
                end
            end

            ind = ind +1;
            if ind > options.numFrame
                break;
            end
        end
    end

    if isempty(faceloc1) && isempty(faceloc2)
        F = [];
        return;
    else
        if ~isempty(faceloc2)
            faceloc = faceloc2;
        else
            faceloc = faceloc1;
        end
    end

    XT = zeros(options.imageSize(1),ind - 1,3); 
    TY = zeros(ind -1,options.imageSize(2),3);

    for i = 1:ind-1
        frame_crop = frames{i}(faceloc(1,2):(faceloc(1,2)+faceloc(1,4)), faceloc(1,1):(faceloc(1,1)+faceloc(1,3)),:);
        frame_nm = imresize(frame_crop, options.imageSize);
        XT(:,i,:) = frame_nm(:,yc,:);
        TY(i,:,:) = frame_nm(xc,:,:);
    end

    % color space transformation
    XY = color_space_transform(uint8(XY),options.colorSpace);
    XT = color_space_transform(uint8(XT),options.colorSpace);
    TY = color_space_transform(uint8(TY),options.colorSpace);

    Hxy = Extract_LDN_TOP_from_Plane(XY,options,'XY');
    Hxt = Extract_LDN_TOP_from_Plane(XT,options,'XT');
    Hty = Extract_LDN_TOP_from_Plane(TY,options,'TY');

    F = [Hxy,Hxt,Hty];
end                        
