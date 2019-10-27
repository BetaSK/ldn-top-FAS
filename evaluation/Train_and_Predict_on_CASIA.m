
function Result = Train_and_Predict_on_CASIA(X_train,Y_train,X_test,Y_test,classifier) 
    
    if strcmp(classifier, 'SVM')
        Result = Train_and_Predict_on_CASIA_SVM(X_train,Y_train,X_test,Y_test);
    elseif  strcmp(classifier, 'ProCRC')     
        Result = Train_and_Predict_on_CASIA_ProCRC(X_train,Y_train,X_test,Y_test);
    end
end
