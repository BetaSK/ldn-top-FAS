function result = Train_and_Predict_on_UVAD_SVM(X_train,Y_train,X_test,Y_test)
    
    folds = 5;
    
    train_num = size(X_train,1);
    indices_shuffled = randperm(train_num);
    sample_num_each_fold = ceil(train_num/folds);
    fold_index = zeros(train_num,1);
    for f = 1:folds
        start = 1+(f-1)*sample_num_each_fold;
        if f == folds
            last = train_num;
        else
            last = f*sample_num_each_fold;
        end
        for i = 1:train_num
            fold_index(indices_shuffled(start:last)) = f;
        end
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
    
    C = 0:2:16;

    mean_hter = zeros(1,numel(C));
    mean_frr = zeros(1,numel(C));
    mean_far = zeros(1,numel(C));
    for i = 1:numel(C)        
         c = 2^C(i);
         eer_dev = zeros(1,folds);
         threshold = zeros(1,folds);
         hter = zeros(1,folds);
         frr = zeros(1,folds);
         far = zeros(1,folds);
         for j = 1:folds
             
               Train_data_fold = X_train(fold_index~=j,:);
               Dev_data_fold = X_train(fold_index==j,:);
               Train_labels_fold = Y_train(fold_index~=j);  
               Dev_labels_fold = Y_train(fold_index==j);
               model{j} = svmtrain(Train_labels_fold, Train_data_fold, ['-t ' num2str(t) ' -c ' num2str(c)]);
               [predicted_label, accuracy, decision_values] = svmpredict(Dev_labels_fold, sparse(Dev_data_fold), model{j});

               [tpr,tnr,info] = vl_roc(Dev_labels_fold, decision_values);
                eer_dev(j) = info.eer;
                threshold(j) = info.threshold;
                
                [predicted_label, accuracy, decision_values] = svmpredict(Y_test,X_test, model);
                predicted_label = ((decision_values>threshold(j))-0.5)*2;

                frr(j) = sum((Y_test - predicted_label) == 2)*100 / sum(Y_test == 1);
                far(j) = sum((predicted_label - Y_test) == 2)*100 / sum(Y_test == -1);
                hter(j) = (far(j) + frr(j)) / 2;
         end
         mean_hter(i) = mean(hter);
         mean_frr(i) = mean(frr);
         mean_far(i) = mean(far);
    end
    [HTER,ind] = min(mean_hter);
    FAR = mean_far(ind);
    FRR = mean_frr(ind);
    
    result.HTER = HTER;
    result.FAR = FAR;
    result.FRR = FRR;
    
end
