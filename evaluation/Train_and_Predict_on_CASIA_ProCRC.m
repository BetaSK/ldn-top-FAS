function result = Train_and_Predict_on_CASIA_ProCRC(X_train,Y_train,X_test,Y_test)

    folds = 5;
    indices_shuffled = randperm(20);
    m = size(X_train,1);
    fold_index = zeros(m,1);
    for i = 1:m
        fold_index(i) = ceil(find(indices_shuffled == ceil(i/12))/4);
    end

    %% load data
    %-tr_descr: the descriptors of training set, each coloum refers to one training image;
    %-tr_label: the ground truth labels for training set;
    %-tr_descr: the descriptors of testing set, each coloum refers to one testing image;
    %-tr_label: the ground truth labels for testing set;
    gamma = -3:0;
    params.model_type = 'ProCRC';
    params.lambda = 1e-2;
    params.class_num = 2;
    
    EER = zeros(1,numel(gamma));

    for g = 1:numel(gamma)
        params.gamma = exp(gamma(g));
        eer_dev = zeros(1,folds);
        for j= 1:folds
            Train_data_fold = X_train(fold_index~=j,:);
            Dev_data_fold = X_train(fold_index==j,:);
            Train_labels_fold = Y_train(fold_index~=j);  
            Dev_labels_fold = Y_train(fold_index==j);

            fr_dat_split.tr_descr = Train_data_fold';
            fr_dat_split.tr_label = (Train_labels_fold'+3)/2;
            fr_dat_split.tt_descr = Dev_data_fold';
            fr_dat_split.tt_label = (Dev_labels_fold'+3)/2;

            %% run ProCRC
            Alpha = ProCRC(fr_dat_split, params);
            [pred_tt_label, pre_matrix,pos_prob] = ProMax(Alpha, fr_dat_split, params);

            [tpr,tnr,info] = vl_roc(Dev_labels_fold, pos_prob(1,:)');
            eer_dev(j) = info.eer;
        end
        EER(g) = mean(eer_dev);
    end
    
    [~,ind] = min(EER);
    params.gamma = exp(gamma(ind));
    fr_dat_split.tr_descr = X_train';
    fr_dat_split.tr_label = (Y_train'+3)/2;
    fr_dat_split.tt_descr = X_test';
    fr_dat_split.tt_label = (Y_test'+3)/2;

    Alpha = ProCRC(fr_dat_split, params);
    [pred_tt_label, pre_matrix,pos_prob] = ProMax(Alpha, fr_dat_split, params);

    [tpr,tnr,info] = vl_roc(Y_test, pos_prob(1,:)');
    result.EER = info.eer;
    result.AUC = info.auc; 
end
