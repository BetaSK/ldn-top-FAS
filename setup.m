function options = setup()

add_all_path();

%% Dataset and Protocol Selection
options.dataset = 'CASIA'; % 'CASIA', 'Replay-Attack', 'MSU', 'UVAD'
switch options.dataset
    case 'CASIA'
        options.dataPath = 'E:\MATLAB\MATLAB\R2016b\bin\SK-LDN-TOP Paper Code\data preparation\dataset\';
    case 'Replay-Attack'
        options.dataPath = 'E:\MATLAB\MATLAB\R2016b\bin\SK-LDN-TOP Paper Code\data preparation\dataset\replay-attack\';
    case 'UVAD'
        options.dataPath = 'H:\UVAD\';
end

%% Face Detector Selection
options.face_detector = setup_MTCNN();

%% Face Image Normalization
options.imageSize = [64,64];

%% Color Space
options.colorSpace = 'HSV+YCbCr';
%colorSpaces = {'Gray','RGB','HSV','YCbCr','RGB+HSV','RGB+YCbCr','HSV+YCbCr','RGB+HSV+YCbCr'};
%% LDN-TOP Parameters setup
options.numFrame = 55;
options.sigma = [1.0,1.5,2.0];

% block division
options.blockSize_xy = [16,16];
options.overlap_xy = [0,0];
options.blockSize_xt = [options.imageSize(1), options.numFrame];
options.overlap_xt = [0,0]; 
options.blockSize_ty = [options.numFrame,options.imageSize(2)];
options.overlap_ty = [0,0];

%% classifier
options.classifier = 'ProCRC';

end