function Result = Train_and_Predict_on_Replay_Attack_ProCRC(X_train,Y_train,X_devel,Y_devel,X_test, Y_test)

    gamma = -3:0;
    params.model_type = 'ProCRC';
    params.lambda = 1e-2;
    params.class_num = 2;

    EER_dev = zeros(1,numel(gamma));
    AUC_dev = zeros(1,numel(gamma));
    threshold = zeros(1,numel(gamma));
    %% load data
    %-tr_descr: the descriptors of training set, each coloum refers to one training image;
    %-tr_label: the ground truth labels for training set;
    %-tr_descr: the descriptors of testing set, each coloum refers to one testing image;
    %-tr_label: the ground truth labels for testing set;
    for g = 1:numel(gamma)
        params.gamma = exp(gamma(g));
        
        fr_dat_split.tr_descr = X_train';
        fr_dat_split.tr_label = (Y_train'+3)/2;
        fr_dat_split.tt_descr = X_devel';
        fr_dat_split.tt_label = (Y_devel'+3)/2;

        %% run ProCRC
        Alpha = ProCRC(fr_dat_split, params);
        [pred_tt_label, pre_matrix,pos_prob] = ProMax(Alpha, fr_dat_split, params);

        [tpr,tnr,info] = vl_roc(Y_devel, pos_prob(1,:)');
        EER_dev(g) = info.eer;
        AUC_dev(g) = info.auc;
        threshold(g) = info.threshold;
    end
    
    [eer_dev,ind] = min(EER_dev);
    auc_dev = AUC_dev(ind);
    thr = threshold(ind);
    params.gamma = exp(gamma(ind));
    fr_dat_split.tr_descr = X_train';
    fr_dat_split.tr_label = (Y_train'+3)/2;
    fr_dat_split.tt_descr = X_test';
    fr_dat_split.tt_label = (Y_test'+3)/2;

    Alpha = ProCRC(fr_dat_split, params);
    [pred_tt_label, pre_matrix,pos_prob] = ProMax(Alpha, fr_dat_split, params);
    
    predicted_label = ((pos_prob>thr)-0.5)*2;
    FRR = sum((Y_test' - predicted_label) == 2)*100 / sum(Y_test' == 1); 
    FAR = sum((predicted_label - Y_test') == 2)*100 / sum(Y_test == -1);
    HTER = (FAR + FRR) / 2;
    
    Result.EER_devel = eer_dev;
    Result.AUC_devel = auc_dev;
    Result.HTER_test = HTER;
    Result.FAR_test = FAR;
    Result.FRR_test = FRR;
end