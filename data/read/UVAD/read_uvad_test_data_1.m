function [test_data,test_labels] = read_uvad_test_data_1(path)

    fid_test_real_canon = fopen(strcat(path,'positive/real-canon.txt'));
    fid_test_real_panasonic = fopen(strcat(path,'positive/real-panasonic.txt'));
    fid_test_real_nikon = fopen(strcat(path,'positive/real-nikon.txt'));
    
    path_test_real_canon = textscan(fid_test_real_canon,'%s');
    path_test_real_panasonic = textscan(fid_test_real_panasonic,'%s');
    path_test_real_nikon = textscan(fid_test_real_nikon,'%s');
    
    test_real = [path_test_real_canon{1,1};path_test_real_panasonic{1,1};path_test_real_nikon{1,1}];
    
    fid_test_attack_canon = fopen(strcat(path,'negative/attack-canon-allcameras-allmonitors.txt'));
    fid_test_attack_panasonic = fopen(strcat(path,'negative/attack-panasonic-allcameras-allmonitors.txt'));
    fid_test_attack_nikon = fopen(strcat(path,'negative/attack-nikon-allcameras-allmonitors.txt'));
    
    path_test_attack_canon = textscan(fid_test_attack_canon,'%s');
    path_test_attack_panasonic = textscan(fid_test_attack_panasonic,'%s');
    path_test_attack_nikon = textscan(fid_test_attack_nikon,'%s');
    
    test_attack = [path_test_attack_canon{1,1};path_test_attack_panasonic{1,1};path_test_attack_nikon{1,1}];
    
    test_data = [test_real;test_attack];
    test_labels = [ones(length(test_real),1);-1*ones(length(test_attack),1)];

    fclose('all');
end