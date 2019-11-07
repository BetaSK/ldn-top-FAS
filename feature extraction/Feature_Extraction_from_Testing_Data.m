function [X_test,Y_test] = Feature_Extraction_from_Testing_Data(options,data)

    TeNum = length(data.testData);  % number of test samples
    X_test = [];
    for i = 1:TeNum
        fprintf('testing video: %d\n',i);
        v = VideoReader(strcat(options.dataPath,data.testData{i}));
        F = Feature_Extraction_VideoEvaluation_SequenceFeatures(v,options);
        if isempty(X_test)
            X_test = F;
            Y_test = data.testLabels(i);
        else
            X_test = [X_test;F];
            Y_test = [Y_test;data.testLabels(i)];
        end
    end
    X_test = double(X_test); Y_test = double(Y_test);
end
