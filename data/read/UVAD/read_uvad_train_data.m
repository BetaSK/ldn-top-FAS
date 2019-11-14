function [train_data,train_labels] = read_uvad_train_data(path)

    fid_train_real_sony = fopen(strcat(path,'positive/real-sony.txt'));
    fid_train_real_olympus = fopen(strcat(path,'positive/real-olympus.txt'));
    fid_train_real_kodac = fopen(strcat(path,'positive/real-kodac.txt'));
    
    path_train_real_sony = textscan(fid_train_real_sony,'%s');
    path_train_real_olympus = textscan(fid_train_real_olympus,'%s');
    path_train_real_kodac = textscan(fid_train_real_kodac,'%s');
    
    train_real = [path_train_real_sony{1,1};path_train_real_olympus{1,1};path_train_real_kodac{1,1}];
    
    fid_train_attack_sony = fopen(strcat(path,'negative/attack-sony-allcameras-allmonitors.txt'));
    fid_train_attack_olympus = fopen(strcat(path,'negative/attack-olympus-allcameras-allmonitors.txt'));
    fid_train_attack_kodac = fopen(strcat(path,'negative/attack-kodac-allcameras-allmonitors.txt'));
    
    path_train_attack_sony = textscan(fid_train_attack_sony,'%s');
    path_train_attack_olympus = textscan(fid_train_attack_olympus,'%s');
    path_train_attack_kodac = textscan(fid_train_attack_kodac,'%s');
    
    train_attack = [path_train_attack_sony{1,1};path_train_attack_olympus{1,1};path_train_attack_kodac{1,1}];
    
    train_data = [train_real;train_attack];
    train_labels = [ones(length(train_real),1);-1*ones(length(train_attack),1)];

    fclose('all');
end
