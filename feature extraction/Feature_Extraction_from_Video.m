function F = Feature_Extraction_from_Video(v,options,v_ind,istrain)
if strcmp(options.evaluation, 'Video')
    % Video-based evaluation refers to recognize the whole video as individual sample
    if strcmp(options.featureType,'frame') % frame-based feature refers to feature extracted from single frame
        F = Feature_Extraction_VideoEvaluation_FrameFeatures(v,options,v_ind,istrain);
    else % sequence-based feature refers to feature extracted from several frames
        F = Feature_Extraction_VideoEvaluation_SequenceFeatures(v,options,v_ind,istrain);
    end
else
    if strcmp(options.featureType,'frame') % frame-based feature refers to feature extracted from single frame
        F = Feature_Extraction_FrameEvaluation_FrameFeatures(v,options,v_ind,istrain);
    end
end