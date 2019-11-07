% load samples
%load('.\samples\CASIA_LDN_TOP(1.0,1.5,2.0)_55Frames_HSV_YCbCr.mat');
%load('.\samples\Replay_Attack_LDN_TOP(0.3,0.6,0.9)_50Frames_HSV.mat');
load('.\samples\UVAD_LDN_TOP(1.0,1.5,2.0)_25Frames_HSV_YCbCr.mat');

% select classifier
classifier = 'ProCRC';

% train and predict
%result = Train_and_Predict_on_CASIA(X_train,Y_train,X_test,Y_test,classifier)
%result = Train_and_Predict_on_Replay_Attack(X_train,Y_train,X_devel,Y_devel,X_test,Y_test,classifier)
result = Train_and_Predict_on_UVAD(X_train,Y_train,X_test,Y_test,classifier)