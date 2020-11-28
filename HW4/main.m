%% Splitting the data and putting it into the 3 different datastores
% DO NOT RUN,  Used classification learner which withhelads 15% for
% validation itself with holdout validation.
%imds = imageDatastore('NWPU-RESISC45','IncludeSubfolders',true,'LabelSource','foldernames');
%[training, validation, testing] = splitEachLabel(imds,0.714285,0.142857);
%% RUN THIS DATA SPLITTER
imds = imageDatastore('NWPU-RESISC45','IncludeSubfolders',true,'LabelSource','foldernames');
[training, testing] = splitEachLabel(imds,0.714285);
%% Load the pretrained VGG16 model on imagenet (NEED Deep Learning License!)
net = vgg16('Weights','imagenet');
net.Layers
inputSize = net.Layers(1).InputSize;
analyzeNetwork(net);

%% Extracting Image Features (NEED Deep Learning License!)
%out of memory if the mini batch size is not reduced
gpuDevice(1);

augimdsTrain = augmentedImageDatastore(inputSize(1:2),training);
augimdsTest = augmentedImageDatastore(inputSize(1:2),testing);

layer = 'fc6';
featuresTestfc6 = activations(net,augimdsTest,layer,'OutputAs','rows','MiniBatchSize', 32);
featuresTrainfc6 = activations(net,augimdsTrain,layer,'OutputAs','rows','MiniBatchSize', 32);

layer = 'fc7';
featuresTestfc7 = activations(net,augimdsTest,layer,'OutputAs','rows','MiniBatchSize', 32);
featuresTrainfc7 = activations(net,augimdsTrain,layer,'OutputAs','rows','MiniBatchSize', 32);

layer = 'fc8';
featuresTestfc8 = activations(net,augimdsTest,layer,'OutputAs','rows','MiniBatchSize', 32);
featuresTrainfc8 = activations(net,augimdsTrain,layer,'OutputAs','rows','MiniBatchSize', 32);


%% Q1 Training


%% labels

TrainLabels = training.Labels;
TestLabels = testing.Labels;
%% fc1 KNN
[trainedClassifier, validationAccuracy] = knnfc6(featuresTrainfc6, TrainLabels);
YPredfc6 = trainedClassifier.predictFcn(featuresTestfc6); 
accuracy = mean(YPredfc6 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc6,TestLabels);
disp(ch);
%% fc1 LDAPCA
[trainedClassifier, validationAccuracy] = LDAPCAfc6(featuresTrainfc6, TrainLabels);
YPredfc6 = trainedClassifier.predictFcn(featuresTestfc6); 
accuracy = mean(YPredfc6 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc6,TestLabels);
disp(ch);
%% fc2 KNN
[trainedClassifier, validationAccuracy] = knnfc7(featuresTrainfc7, TrainLabels);
YPredfc7 = trainedClassifier.predictFcn(featuresTestfc7); 
accuracy = mean(YPredfc7 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc7,TestLabels);
disp(ch);
%% fc2 LDAPCA
[trainedClassifier, validationAccuracy] = LDAPCAfc7(featuresTrainfc7, TrainLabels);
YPredfc7 = trainedClassifier.predictFcn(featuresTestfc7); 
accuracy = mean(YPredfc7 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc7,TestLabels);
disp(ch);
%% fc3 KNN
[trainedClassifier, validationAccuracy] = knnfc8(featuresTrainfc8, TrainLabels);
YPredfc8 = trainedClassifier.predictFcn(featuresTestfc8); 
accuracy = mean(YPredfc7 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc8,TestLabels);
disp(ch);
%% fc3 LDAPCA
[trainedClassifier, validationAccuracy] = LDAPCAfc8(featuresTrainfc8, TrainLabels);
YPredfc8 = trainedClassifier.predictFcn(featuresTestfc8); 
accuracy = mean(YPredfc8 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc8,TestLabels);
disp(ch);

%% Q2

%% fc1 SVM
[trainedClassifier, validationAccuracy] = SVMfc6(featuresTrainfc6, TrainLabels);
YPredfc6 = trainedClassifier.predictFcn(featuresTestfc6); 
accuracy = mean(YPredfc6 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc6,TestLabels);
disp(ch);

%% fc2 SVM
[trainedClassifier, validationAccuracy] = SVMfc7(featuresTrainfc7, TrainLabels);
YPredfc7 = trainedClassifier.predictFcn(featuresTestfc7); 
accuracy = mean(YPredfc7 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc7,TestLabels);
disp(ch);
%% fc3 SVM
[trainedClassifier, validationAccuracy] = SVMfc8(featuresTrainfc8, TrainLabels);
YPredfc8 = trainedClassifier.predictFcn(featuresTestfc8); 
accuracy = mean(YPredfc8 == TestLabels);
disp(accuracy);
ch = confusionchart(YPredfc8,TestLabels);
disp(ch);