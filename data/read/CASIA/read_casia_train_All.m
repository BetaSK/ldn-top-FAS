function [train_data,train_labels,subject_indices,subject_num] = read_casia_train_All(path)
    fid_train_all = fopen(strcat(path,'All_casia_train.txt'));
    
    path_train_all = textscan(fid_train_all,'%s');
    
    train_data = path_train_all{1,1};

    train_num = length(train_data);
    
    subject_num = train_num/12;

    train_labels = zeros(12*subject_num,1);
    subject_indices = zeros(12*subject_num,1);

    for i = 1:subject_num
        for j = 1:12
            v_ind = (i-1)*12 + j;
            if j == 1 || j == 2 || j == 9
                train_labels(v_ind) = 1;
            else
                train_labels(v_ind) = -1;
            end
            subject_indices(v_ind) = i;
        end
    end  
    fclose('all');
end