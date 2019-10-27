function [test_data,test_labels,test_subject_indices,test_subject_num] = read_replay_attack_test_data(path)
    fid_test_real = fopen(strcat(path,'real-test.txt'));
    
    path_test_real = textscan(fid_test_real,'%s');
    
    test_real = path_test_real{1,1};


    fid_test_attack = fopen(strcat(path,'attack-grandtest-allsupports-test.txt'));
  
    path_test_attack = textscan(fid_test_attack,'%s');
    
    test_attack = path_test_attack{1,1};
    
    test_data = [test_real;test_attack];
    test_labels = [ones(length(test_real),1);-1*ones(length(test_attack),1)];
    
    real_indices = zeros(length(test_real),1);
    attack_indices = zeros(length(test_attack),1);
    
    for i = 1:length(test_real)
        real_indices(i) = ceil(i/4);
    end
    
    
    for j = 1:length(test_attack)
        if j<=80
           attack_indices(j) = ceil(j/4); 
        elseif j<=160
            attack_indices(j) = ceil((j-60)/4);
        elseif j<=200
            attack_indices(j) = ceil((j-120)/2);
        elseif j<=280
            attack_indices(j) = ceil((j-150)/4);
        elseif j<=360
            attack_indices(j) = ceil((j-210)/4);
        else
            attack_indices(j) = ceil((j-270)/2);
        end
    end
    test_subject_indices = [real_indices;attack_indices];
    test_subject_num = 20;
    fclose('all');
end