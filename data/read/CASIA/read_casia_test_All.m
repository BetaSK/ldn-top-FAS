function [test_data,test_labels,subject_indices,subject_num] = read_casia_test_All(path)
    fid_test_all = fopen(strcat(path,'All_casia_test.txt'));
    
    path_test_all = textscan(fid_test_all,'%s');
    
    test_data = path_test_all{1,1};

    test_num = length(test_data);
    
    subject_num = test_num/12;

    test_labels = zeros(12*subject_num,1);
    subject_indices = zeros(12*subject_num,1);

    for i = 1:subject_num
        for j = 1:12
            v_ind = (i-1)*12 + j;
            if j == 1 || j == 2 || j == 9
                test_labels(v_ind) = 1;
            else
                test_labels(v_ind) = -1;
            end
            subject_indices(v_ind) = i;
        end
    end  
    fclose('all');
end