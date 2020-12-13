%% Splitting the data and putting it into the 3 different datastores
% DO NOT RUN,  Used classification learner which withhelads 15% for
% validation itself with holdout validation.
%imds = imageDatastore('NWPU-RESISC45','IncludeSubfolders',true,'LabelSource','foldernames');
%[training, validation, testing] = splitEachLabel(imds,0.714285,0.142857);
%% RUN THIS DATA SPLITTER
imds = imageDatastore('NWPU-RESISC45','IncludeSubfolders',true,'LabelSource','foldernames');
[training, testing] = splitEachLabel(imds,0.714285);
%[training, testing] = splitEachLabel(imds,0.95);

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

layer = 'pool5';
featuresTestConv5_3 = activations(net,augimdsTest,layer,'OutputAs','rows','MiniBatchSize', 32);
featuresTrainConv5_3 = activations(net,augimdsTrain,layer,'OutputAs','rows','MiniBatchSize', 32);


%% labels
TrainLabels = training.Labels;
TestLabels = testing.Labels;
%% GMM+PCA
%[~,score] = pca(featuresTrainConv5_3,'NumComponents',2);

%GMModels = cell(3,1); % Preallocation
options = statset('MaxIter',1000);
rng(1); % For reproducibility
nc = [32, 64, 128, 32, 64, 128];

for j = 1:length(nc)
    if (j > 3)
        [~,score] = pca(featuresTrainConv5_3,'NumComponents',24);
        scoreArray{j} = score;
        GMModels{j} = fitgmdist(score,nc(j),'Options',options,'SharedCov',true,'CovType','diagonal', 'ProbabilityTolerance',0.0000003)
        fprintf('\n GM Mean for %i Component(s) and 24 Dimensions\n',nc(j));
        Mu = GMModels{j}.mu;
        AIC(j)= GMModels{j}.AIC;
        continue
    end
    [~,score] = pca(featuresTrainConv5_3,'NumComponents',16);
    scoreArray{j} = score;
    GMModels{j} = fitgmdist(score,nc(j),'Options',options,'SharedCov',true,'CovType','diagonal', 'ProbabilityTolerance',0.0000003)
    fprintf('\n GM Mean for %i Component(s) and 16 Dimensions\n',nc(j));
    Mu = GMModels{j}.mu;
    AIC(j)= GMModels{j}.AIC;
end
[minAIC,numComponents] = min(AIC);
BestModel = GMModels{numComponents} % 128 components and 16 dimensions



%% Plot 2 Dimensions
%[~,score] = pca(featuresTrainConv5_3,'NumComponents',2);

options = statset('MaxIter',1000);
rng(1); % For reproducibility
nc = [32, 64, 128, 32, 64, 128];
kd = [16,24];

for j = 1:length(nc)
    [~,score] = pca(featuresTestConv5_3,'NumComponents',2);
    GMModels{j} = fitgmdist(score,2,'Options',options,'SharedCov',true,'CovType','diagonal', 'ProbabilityTolerance',0.0000003);
    fprintf('\n GM Mean for %i Component(s) and 2 Dimensions\n',nc(j));
    Mu = GMModels{j}.mu;
    AIC(j)= GMModels{j}.AIC;
    if (j == 3)
    break
    end
end
[minAIC,numComponents] = min(AIC)
BestModel = GMModels{numComponents}
for j = 1:length(nc)
    figure
    %subplot(4,4,j)
    h1 = gscatter(score(:,1),score(:,2),TestLabels);
    h = gca;
    hold on
    gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(GMModels{j},[x0 y0]),x,y);
    fcontour(gmPDF,'MeshDensity',100)
    title(sprintf('GM Model - %i Component(s)',nc(j)));
    xlabel('1st principal component');
    ylabel('2nd principal component');
    hold off
    if(j==3)
        break
    end
end
g = legend(h1);
g.Position = [0.7 0.25 0.1 0.1];



%% Extract Posterior Probabilities for 128 components and 16 dimensions

%posterior probabilities for demonstration purposes:
[~,score] = pca(featuresTrainConv5_3,'NumComponents',16);
P1 = posterior(GMModels{1}, score);
P2 = posterior(GMModels{2}, score);
P3 = posterior(GMModels{3}, score); %best

[~,score] = pca(featuresTrainConv5_3,'NumComponents',24);
P4 = posterior(GMModels{4}, score);
P5 = posterior(GMModels{5}, score);
P6 = posterior(GMModels{6}, score);