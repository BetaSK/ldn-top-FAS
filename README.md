# ldn-top-FAS

This is a Matlab implementation of our paper:

"Face Anti-spoofing Based on Dynamic Color Texture Analysis Using Local Directional Number Pattern", submitted to TIFS, 2019.

### Requirements

1. `MTCNN face detector`: https://github.com/kpzhang93/MTCNN_face_detection_alignment
2. `Matlab R2016b` to reproduce our results, later version may lead to bias.
3. `libsvm`:  https://www.csie.ntu.edu.tw/~cjlin/libsvm/ 
4. `ProCRC`: http://www4.comp.polyu.edu.hk/~cslzhang/code/ProCRC_code_ver_1.0.zip

### Data Preparation

In this paper, we use three challenging public datasets, namely, [CASIA Face Anti-Spoofing Database (CASIA FASD)](https://pythonhosted.org/bob.db.casia_fasd/#), [Replay-Attack Database](https://www.idiap.ch/dataset/replayattack) and  [Unicamp Video-Attack Database (UVAD)]().  

Download the datasets and put them in `.\data\dataset`.

### Demo

We provide the demo code to produce the best result  of CASIA FASD we reported in the paper.  Run `demo.m`,  you can get the classification result.

### Usage

Or you want to run the whole process, you can follow the steps below:

1. setup parameters

   You can change the parameters of our method in `setup.m`, including dataset path, color space, et.al.

2. Run 

   Run `run_antispoofing.m`.

### Results

![image-20191116162414489](https://github.com/BetaSK/ldn-top-FAS/blob/master/samples/result1.png)

![image-20191116162456535](https://github.com/BetaSK/ldn-top-FAS/blob/master/samples/result2.png)

