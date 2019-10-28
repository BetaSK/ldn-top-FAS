
function mtcnn_detector = setup_MTCNN()

%minimum size of face
minsize=100;

%path of toolbox
caffe_path='E:\caffe-master';
pdollar_toolbox_path='E:\toolbox_pdollar';
caffe_model_path='.\face detection\MTCNN_face_detection\MTCNNv2\model';
addpath(genpath(caffe_path));
addpath(genpath(pdollar_toolbox_path));

%use cpu
caffe.set_mode_cpu();
% gpu_id=0;
% caffe.set_mode_gpu();	
% caffe.set_device(gpu_id);

%three steps's threshold
threshold=[0.6 0.7 0.7];

%scale factor
factor=0.709;

%load caffe models
prototxt_dir =strcat(caffe_model_path,'/det1.prototxt');
model_dir = strcat(caffe_model_path,'/det1.caffemodel');
PNet=caffe.Net(prototxt_dir,model_dir,'test');
prototxt_dir = strcat(caffe_model_path,'/det2.prototxt');
model_dir = strcat(caffe_model_path,'/det2.caffemodel');
RNet=caffe.Net(prototxt_dir,model_dir,'test');	
prototxt_dir = strcat(caffe_model_path,'/det3.prototxt');
model_dir = strcat(caffe_model_path,'/det3.caffemodel');
ONet=caffe.Net(prototxt_dir,model_dir,'test');
prototxt_dir =  strcat(caffe_model_path,'/det4.prototxt');
model_dir =  strcat(caffe_model_path,'/det4.caffemodel');
LNet=caffe.Net(prototxt_dir,model_dir,'test');

mtcnn_detector.minsize = minsize;
mtcnn_detector.PNet = PNet;
mtcnn_detector.RNet = RNet;
mtcnn_detector.ONet = ONet;
mtcnn_detector.LNet = LNet;
mtcnn_detector.threshold = threshold;
mtcnn_detector.factor = factor;
end
