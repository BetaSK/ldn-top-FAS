function [X_devel,Y_devel] = Feature_Extraction_from_Development_Data(options,data)

    DeNum = length(data.develData);  % number of devel samples
    X_devel = [];
    for i = 1:DeNum
        fprintf('development video: %d\n',i);
        v = VideoReader(strcat(options.dataPath,'replayattack-devel/',data.develData{i}));
        F = Feature_Extraction_VideoEvaluation_SequenceFeatures(v,options);
        if isempty(X_devel)
            X_devel = F;
            Y_devel = data.develLabels(i);
        else
            X_devel = [X_devel;F];
            Y_devel = [Y_devel;data.develLabels(i)];
        end
    end
    
    X_devel = double(X_devel); Y_devel = double(Y_devel);
end