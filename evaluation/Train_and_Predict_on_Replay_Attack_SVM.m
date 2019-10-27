function result = Train_and_Predict_on_Replay_Attack_SVM(X_train,Y_train,X_devel,Y_devel,X_test,Y_test)
    
    C = 0:2:10;
    model = cell(1,numel(C));
    eer_dev = zeros(1,numel(C));
    auc = zeros(1,numel(C));
    threshold = zeros(1,numel(C));
    kernel = 'HIK';
    switch kernel
        case 'RBF'
            t = 2;
        case 'HIK'
            t = 1;
        case 'Linear'
            t = 0;
    end
    
    for i = 1:numel(C)        
        c = 2^C(i);
        model{i} = svmtrain(Y_train, X_train, ['-t ' num2str(t) ' -c ' num2str(c)]);
       [predicted_label, accuracy, decision_values] = svmpredict(Y_devel,X_devel,model{i});

       [tpr,tnr,info] = vl_roc(Y_devel,decision_values(:,1));
        eer_dev(i) = info.eer;
        threshold(i) = info.threshold;
        auc(i) = info.auc;
    end
    [~,ind] = min(eer_dev);
    eer_devel = eer_dev(ind);
    thr = threshold(ind);
    AUC = auc(ind);
    Model = model{ind};
    
    [predicted_label, accuracy, decision_values] = svmpredict(Y_test, X_test, Model);
    
    predicted_label = ((decision_values>thr)-0.5)*2;
    
    FRR = sum((Y_test - predicted_label) == 2)*100 / sum(Y_test == 1); 
    FAR = sum((predicted_label - Y_test) == 2)*100 / sum(Y_test == -1);

    HTER = (FAR + FRR) / 2;
    result.EER_devel = eer_devel;
    result.AUC_devel = AUC;
    result.HTER_test = HTER;
    result.FAR_test = FAR;
    result.FRR_test = FRR;
end
