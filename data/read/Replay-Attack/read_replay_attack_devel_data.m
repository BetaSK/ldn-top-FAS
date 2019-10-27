function [devel_data,devel_labels,devel_subject_indices,devel_subject_num] = read_replay_attack_devel_data(path)
    fid_devel_real = fopen(strcat(path,'real-devel.txt'));
    
    path_devel_real = textscan(fid_devel_real,'%s');
    
    devel_real = path_devel_real{1,1};


    fid_devel_attack = fopen(strcat(path,'attack-grandtest-allsupports-devel.txt'));
  
    path_devel_attack = textscan(fid_devel_attack,'%s');
    
    devel_attack = path_devel_attack{1,1};
    
    devel_data = [devel_real;devel_attack];
    devel_labels = [ones(length(devel_real),1);-1*ones(length(devel_attack),1)];
    
    real_indices = zeros(length(devel_real),1);
    attack_indices = zeros(length(devel_attack),1);
    
    for i = 1:length(devel_real)
        real_indices(i) = ceil(i/4);
    end
    
    
    for j = 1:length(devel_attack)
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
    devel_subject_indices = [real_indices;attack_indices];
    devel_subject_num = 15;
    fclose('all');
end