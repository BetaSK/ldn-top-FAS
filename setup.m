function options = setup()

add_all_path();

%% Dataset and Protocol Selection
options.dataset = 'CASIA'; % 'CASIA', 'Replay-Attack', 'UVAD'
options.dataPath = '.\data\dataset';

%% Face Detector Selection
options.face_detector = setup_mtcnn();

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

%% classifier
options.classifier = 'ProCRC';

end
