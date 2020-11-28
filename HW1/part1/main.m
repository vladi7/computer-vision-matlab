clear 
clc
classes = {'airplane', 'airport', 'baseball_diamond', 'basketball_court', 'beach', 'bridge', 'chaparral', 'church', 'circular_farmland', 'cloud', 'commercial_area', 'dense_residential', 'desert', 'forest', 'freeway'};

%histogram for just one picture in the specified path
path = 'NWPU-RESISC45\airport\airport_003.jpg';
KMeansSinglePicture(path);

%compute all histograms and store their values in 'histogramsMatrix'. Please use small number of pictures(instead of 2) from each class just so do not waste a lot of time. 
%it does support 100 if one has a few hours to wait while computing histograms for all 1,500 images. 
histogramsMatrix = getHistForManyPictures(2, classes);
disp(size(histogramsMatrix));

%Classify nearest neighbors and plot the confusion matrix. First parameter is K and
%the second one is classes
ClassifyNearestNeighbors(1, classes);