function [X_train,Y_train] = Feature_Extraction_from_Training_Data(options,data)

    TrNum = length(data.trainData);  % number of training samples
    X_train = [];
    for i = 1:TrNum
        fprintf('training video: %d\n',i);
        v = VideoReader(strcat(options.dataPath,data.trainData{i}));
        F = Feature_Extraction_VideoEvaluation_SequenceFeatures(v, options);
        if isempty(X_train)
            X_train = F;
            Y_train = data.trainLabels(i);
        else
            X_train = [X_train;F];
            Y_train = [Y_train;data.trainLabels(i)];
        end
        
    end
    X_train = double(X_train); Y_train = double(Y_train);
    
end
