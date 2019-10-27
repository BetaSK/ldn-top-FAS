function result = Train_and_Predict_on_CASIA_SVM(X_train,Y_train,X_test, Y_test)
    
    folds = 5;
    indices_shuffled = randperm(20);
    m = size(X_train,1);
    fold_index = zeros(m,1);
    for i = 1:m
        fold_index(i) = ceil(find(indices_shuffled == ceil(i/12))/4);
    end
    kernel = 'HIK';
    switch kernel
        case 'RBF'
            t = 2;
        case 'HIK'
            t = 1;
        case 'Linear'
            t = 0;
    end
    
    C = 0:2:10;
    
    EER_C = zeros(1,numel(C));
    
    for i = 1:numel(C)        
         c = 2^C(i);
         eer_c = zeros(1,folds);                
         for j = 1:folds
             
               Train_data_fold = X_train(fold_index~=j,:);
               Dev_data_fold = X_train(fold_index==j,:);
               Train_labels_fold = Y_train(fold_index~=j);  
               Dev_labels_fold = Y_train(fold_index==j);
               model{j} = svmtrain(Train_labels_fold, Train_data_fold, ['-t ' num2str(t) ' -c ' num2str(c)]);
               
               [predicted_label, accuracy, decision_values] = svmpredict(Dev_labels_fold, sparse(Dev_data_fold), model{j});

               [tpr,tnr,info] = vl_roc(Dev_labels_fold, decision_values);
                eer_c(j) = info.eer;
         end
         EER_C(i) = mean(eer_c);
    end
    [~,ind] = min(EER_C);
    c = 2^C(ind);
    % train on all training sample
    Model = svmtrain(Y_train,sparse(X_train),['-t ' num2str(t) ' -c ' num2str(c)]);
    [predicted_label, accuracy, decision_values] = svmpredict(Y_test, X_test, Model);
    % threshold-independent index: EER and AUC
    [tpr,tnr,info] = vl_roc(Y_test, decision_values);
    result.EER = info.eer;
    result.AUC = info.auc;
end
