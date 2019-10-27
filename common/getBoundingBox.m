function faceloc = getBoundingBox(options, frame)

    [bboxes, ~] = detect_face(frame,options.face_detector.minsize,options.face_detector.PNet,...
                options.face_detector.RNet,options.face_detector.ONet,...
                options.face_detector.LNet,options.face_detector.threshold,false,options.face_detector.factor);

    if ~isempty(bboxes)
        % truncation
        if bboxes(1,1)<1
            bboxes(1,1) = 1;
        end
        if bboxes(1,2)<1
            bboxes(1,2) = 1;
        end
        if bboxes(1,3)>size(frame,2)
            bboxes(1,3) = size(frame,2);
        end
        if bboxes(1,4)>size(frame,1)
            bboxes(1,4) = size(frame,1);
        end

        faceloc = floor([bboxes(1,1:2) bboxes(1,3:4)- bboxes(1,1:2)]);
     else
         faceloc = [];
    end
end    