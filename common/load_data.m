function data = load_data(options)

    switch lower(options.dataset)
        case 'casia'
            [train_data,train_labels] = ...
                read_casia_train_All('.\data\read\CASIA\');
            [test_data,test_labels] = ...
                read_casia_test_All('.\data\read\CASIA\');
            data.trainData = train_data;
            data.trainLabels = train_labels;
            data.testData = test_data;
            data.testLabels = test_labels;
            data.hasDevel = 0;
        case 'replay-attack'
            [train_data,train_labels] = ...
                read_replay_attack_train_data('.\data\read\Replay-Attack\');
            [devel_data,devel_labels] = ...
                read_replay_attack_devel_data('.\data\read\Replay-Attack\');
            [test_data,test_labels] = ...
                read_replay_attack_test_data('.\data\read\Replay-Attack\');
            data.trainData = train_data;
            data.trainLabels = train_labels;
            data.develData = devel_data;
            data.develLabels = devel_labels;
            data.testData = test_data;
            data.testLabels = test_labels;
            data.hasDevel = 1;
        case 'uvad'
            [train_data,train_labels] = ...
                read_uvad_train_data('.\data\read\UVAD\protocols\train\');
            [test_data,test_labels] = ...
                read_uvad_test_data('.\data\read\UVAD\protocols\test\');
            data.trainData = train_data;
            data.trainLabels = train_labels;
            data.testData = test_data;
            data.testLabels = test_labels;
            data.hasDevel = 0;
        otherwise
            error('The input dataset has no support!');
    end
end
