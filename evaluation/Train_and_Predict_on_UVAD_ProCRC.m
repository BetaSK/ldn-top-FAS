function result = Train_and_Predict_on_UVAD_ProCRC(X_train,Y_train,X_test,Y_test)

    gamma = -3:0;
    params.model_type = 'ProCRC';%'R-ProCRC';
    params.lambda = 1e-2;
    params.class_num = 2;

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

    %% load data
    %-tr_descr: the descriptors of training set, each coloum refers to one training image;
    %-tr_label: the ground truth labels for training set;
    %-tr_descr: the descriptors of testing set, each coloum refers to one testing image;
    %-tr_label: the ground truth labels for testing set;
    mean_hter = zeros(1,numel(gamma));
    mean_frr = zeros(1,numel(gamma));
    mean_far = zeros(1,numel(gamma));

    %% 交叉验证选择最优参数
    for g = 1:numel(gamma)
        params.gamma = exp(gamma(g));
        hter = zeros(1,folds);
        frr = zeros(1,folds);
        far = zeros(1,folds);
        threshold = zeros(1,folds);
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
            threshold(j) = info.threshold;
            
            fr_dat_split.tr_descr = X_train';
            fr_dat_split.tr_label = (Y_train'+3)/2;
            fr_dat_split.tt_descr = X_test';
            fr_dat_split.tt_label = (Y_test'+3)/2;

            Alpha = ProCRC(fr_dat_split, params);
            [pred_tt_label, pre_matrix,pos_prob] = ProMax(Alpha, fr_dat_split, params);
            
            predicted_label = ((pos_prob>threshold(j))-0.5)*2;
            frr(j) = sum((Y_test' - predicted_label) == 2)*100 / sum(Y_test' == 1); 
            far(j) = sum((predicted_label - Y_test') == 2)*100 / sum(Y_test' == -1);
            hter(j) = (far(j) + frr(j)) / 2;
            
            
        end
        mean_hter(g) = mean(hter);
        mean_frr(g) = mean(frr);
        mean_far(g) = mean(far);
    end

    [result.HTER,ind] = min(mean_hter);
    result.FAR = mean_far(ind);
    result.FRR = mean_frr(ind);
end
