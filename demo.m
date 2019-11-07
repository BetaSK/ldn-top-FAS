% load samples
load('.\samples\CASIA_LDN_TOP(1.0,1.5,2.0)_55Frames_HSV_YCbCr.mat');

% select classifier
classifier = 'ProCRC';

% train and predict
result = Train_and_Predict_on_CASIA(X_train,Y_train,X_test,Y_test,classifier)
