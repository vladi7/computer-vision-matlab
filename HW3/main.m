clear;
addpath('LPP');
beep off;
%% Q1
%(COMPLETE)
data = load('faces-ids-n6680-m417-20x20.mat');
folder = sprintf('ExtraDataSet');
images = dir([folder '\*.jpg']);


for j=1:10
    image = imread([folder '\' images(j).name]);
    resized = imresize(image, [20, 20]);
    rescaled = rescale(resized);
    gray = rgb2gray(rescaled);
    extra_data = gray(:);
    data.faces = [data.faces; extra_data'];
    data.ids = [data.ids; 999];
end

%% Q2 (complete)
[A0, eigv] = getEigenfacemodel(data.faces, 1);
%% Q3(complete)
A1 = getFisherfacemodel(data.faces, A0, data.ids, 64, 1);

%% Q4(complete)
%
[A2, S] = getLaplacianfacemodel(data.faces, A0, data.ids, 64,1);

%% Q5(complete)

n=length(data.ids);
uniqueIDs = unique(data.ids);
numberOfUniqueLabels = length(uniqueIDs);

indexOfQuery = cell(1, 5);
trainIndexes = cell(1, 5);
for i=1:6
    for k=1:numberOfUniqueLabels
        offsets = find(data.ids==uniqueIDs(k));
        indexOfQuery{i}(k) = offsets(i);
        trainIndexes{i} = setdiff(1:n, indexOfQuery{i});
        trainIndexes{i} = data.ids(trainIndexes{i});
    end
end
retrievedIDs = 1:418;

dimensions = [32, 64];
for i=1:length(dimensions)
    for j=1:length(indexOfQuery)
        meanAveragePrecision(i, j) = getQueryMAPeigenface(data.faces, trainIndexes{j}, indexOfQuery{j}, retrievedIDs, dimensions(i));
    end
end
dimensionsForPlotting = 1:1:6;
figure (1);
plot(dimensionsForPlotting, meanAveragePrecision(1,:), '-.k', dimensionsForPlotting, meanAveragePrecision(2,:), '-b');
legend('32', '64');
axis([0 6 0 1]);
xlabel('Q');
ylabel('Mean Average Precision');
title('Eigenface');

dimensions = [8, 16, 24];
for i=1:length(dimensions)
    for j=1:length(indexOfQuery)
        meanAveragePrecision(i, j) = getQueryMAPfisherFace(data.faces, trainIndexes{j}, indexOfQuery{j}, retrievedIDs, dimensions(i));
    end
end
dimensionsForPlotting = 1:1:6;
figure (2);
plot(dimensionsForPlotting, meanAveragePrecision(1,:), '-.k', dimensionsForPlotting, meanAveragePrecision(2,:), ':b', dimensionsForPlotting, meanAveragePrecision(3,:), '-r');
legend('8', '16', '24');
axis([0 6 0 1]);
xlabel('Q');
ylabel('Mean Average Precision');
title('Fisherface');


dimensions = [8, 16, 24];
for i=1:length(dimensions)
    for j=1:length(indexOfQuery)
        meanAveragePrecision(i, j) = getQueryMAPLaplacian(data.faces, trainIndexes{j}, indexOfQuery{j}, retrievedIDs, dimensions(i));
    end
end
dimensionsForPlotting = 1:1:6;
figure (3);
plot(dimensionsForPlotting, meanAveragePrecision(1,:), '-.k', dimensionsForPlotting, meanAveragePrecision(2,:), ':b', dimensionsForPlotting, meanAveragePrecision(3,:), '-r');
legend('8', '16', '24');
axis([0 6 0 1]);
xlabel('Q');
ylabel('Mean Average Precision');
title('Laplacian');




