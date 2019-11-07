% Face Anti-spoofing Based on Dynamic Color Texture Analysis using Local
% Directional Number Pattern
clear;
% parameter setup
options = setup();


% load data                                                                                
data = load_data(options);

%% feature extraction
% feature extraction from Training Data
[X_train, Y_train] = Feature_Extraction_from_Training_Data(options,data);

% feature extraction from Development Data if exist
if data.hasDevel
    [X_devel, Y_devel] = Feature_Extraction_from_Development_Data(options,data);
end
% feature extraction from Testing Data
[X_test, Y_test] = Feature_Extraction_from_Testing_Data(options,data);

%% train and predict
fprintf('Number of frames is: %d\n', options.numFrame);
switch lower(options.dataset)
    case 'casia'
        result = Train_and_Predict_on_CASIA(X_train,Y_train,X_test,Y_test,options.classifier)
    case 'replay-attack'
        result = Train_and_Predict_on_Replay_Attack(X_train,Y_train,X_devel,Y_devel,X_test,Y_test,options.classifier)
    case 'uvad'
        result = Train_and_Predict_on_UVAD(X_train,Y_train,X_test,Y_test,options.classifier)
end

 
