function [train_data,train_labels,train_subject_indices,train_subject_num] = read_replay_attack_train_data(path)
    fid_train_real = fopen(strcat(path,'real-train.txt'));
    
    path_train_real = textscan(fid_train_real,'%s');
    
    train_real = path_train_real{1,1};


    fid_train_attack = fopen(strcat(path,'attack-grandtest-allsupports-train.txt'));
  
    path_train_attack = textscan(fid_train_attack,'%s');
    
    train_attack = path_train_attack{1,1};
    
    train_data = [train_real;train_attack];
    train_labels = [ones(length(train_real),1);-1*ones(length(train_attack),1)];
    
    real_indices = zeros(length(train_real),1);
    attack_indices = zeros(length(train_attack),1);
    
    for i = 1:length(train_real)
        real_indices(i) = ceil(i/4);
    end
    
    
    for j = 1:length(train_attack)
        if j<=60
           attack_indices(j) = ceil(j/4); 
        elseif j<=120
            attack_indices(j) = ceil((j-60)/4);
        elseif j<=150
            attack_indices(j) = ceil((j-120)/2);
        elseif j<=210
            attack_indices(j) = ceil((j-150)/4);
        elseif j<=270
            attack_indices(j) = ceil((j-210)/4);
        else
            attack_indices(j) = ceil((j-270)/2);
        end
    end
    train_subject_indices = [real_indices;attack_indices];
    train_subject_num = 15;
    fclose('all');
end