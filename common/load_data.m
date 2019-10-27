function data = load_data(options)

    switch lower(options.dataset)
        case 'casia'
            [train_data,train_labels,train_subject_indices,train_subject_num] = ...
                read_casia_train_All('E:\MATLAB\MATLAB\R2016b\bin\SK-LDN-TOP Paper Code/data preparation/dataset/CASIAFace/protocols/');
            [test_data,test_labels,test_subject_indices,test_subject_num] = ...
                read_casia_test_All('E:\MATLAB\MATLAB\R2016b\bin\SK-LDN-TOP Paper Code/data preparation/dataset/CASIAFace/protocols/');
            data.trainData = train_data;  % (trNum * 1) cell
            data.trainLabels = train_labels; % (trNum * 1) double
            data.trainSubjectIndices = train_subject_indices; % (trNum * 1) double
            data.trainSubjectNumber = train_subject_num; % double
            data.testData = test_data; % (teNum * 1) cell
            data.testLabels = test_labels; % (teNum * 1) double
            data.testSubjectIndices = test_subject_indices; % (teNum * 1) double
            data.testSubjectNumber = test_subject_num; % double
            data.hasDevel = 0;
        case 'replay-attack'
            [train_data,train_labels,train_subject_indices,train_subject_num] = ...
                read_replay_attack_train_data('./data preparation/dataset/replay-attack/protocols-v3/protocols/');
            [devel_data,devel_labels,devel_subject_indices,devel_subject_num] = ...
                read_replay_attack_devel_data('./data preparation/dataset/replay-attack/protocols-v3/protocols/');
            [test_data,test_labels,test_subject_indices,test_subject_num] = ...
                read_replay_attack_test_data('./data preparation/dataset/replay-attack/protocols-v3/protocols/');
            data.trainData = train_data; % (trNum * 1) cell
            data.trainLabels = train_labels; % (trNum * 1) double
            data.trainSubjectIndices = train_subject_indices; % (trNum * 1) double
            data.trainSubjectNumber = train_subject_num; % double
            data.develData = devel_data; % (deNum * 1) cell
            data.develLabels = devel_labels; % (deNum * 1) double
            data.develSubjectIndices = devel_subject_indices; % (deNum * 1) double
            data.develSubjectNumber = devel_subject_num; % double
            data.testData = test_data; % (teNum * 1) cell
            data.testLabels = test_labels; % (teNum * 1) double
            data.testSubjectIndices = test_subject_indices; % (teNum * 1) double
            data.testSubjectNumber = test_subject_num; % double
            data.hasDevel = 1;
        case 'uvad'
            switch options.protocol
                case 'official'
                    [train_data,train_labels] = ...
                        read_uvad_train_data_1('./data preparation/read/UVAD/protocols/train/');
                    [test_data,test_labels] = ...
                        read_uvad_test_data_1('./data preparation/read/UVAD/protocols/test/');
                otherwise
                    error('This protocol not support.');
            end
            data.trainData = train_data; % (trNum * 1) cell
            data.trainLabels = train_labels; % (trNum * 1) double
            data.trainSubjectIndices = [];
            data.trainSubjectNumber = 0;
            data.testData = test_data; % (teNum * 1) cell
            data.testLabels = test_labels; % (teNum * 1) double
            data.testSubjectIndices = [];
            data.testSubjectNumber = 0;
            data.hasDevel = 0;
        otherwise
            error('The input dataset has no support!');
    end
end