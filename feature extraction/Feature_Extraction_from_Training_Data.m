function [X_train,Y_train,train_indices] = Feature_Extraction_from_Training_Data(options,data)

    TrNum = length(data.trainData);  % number of training samples
    train_indices = [];
    X_train = [];
    for i = 1:TrNum
        fprintf('training video: %d\n',i);
        if strcmp(options.dataset,'Replay-Attack')
            v = VideoReader(strcat(options.dataPath,'replayattack-train/',data.trainData{i}));
        else
            v = VideoReader(strcat(options.dataPath,data.trainData{i}));
        end
        F = Feature_Extraction_VideoEvaluation_SequenceFeatures(v, options);
        if isempty(X_train)
            X_train = F;
            Y_train = data.trainLabels(i);
            if data.trainSubjectNumber ~= 0
                train_indices = data.trainSubjectIndices(i);
            end
        else
            X_train = [X_train;F];
            Y_train = [Y_train;data.trainLabels(i)];
            if data.trainSubjectNumber ~= 0
                train_indices = [train_indices;data.trainSubjectIndices(i)];
            end
        end
        
    end
    X_train = double(X_train); Y_train = double(Y_train);
    
end