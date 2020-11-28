clear;
run ('vlfeat-0.9.20/toolbox/vl_setup');
vl_version verbose
load MPEG.CDVS/hw-2-data.mat; 
%getImagesFeaturesExtraCredit();

%set to 0 for nonmatching
matching = 0;
if matching == 1
%Q1
classes = {'airplane', 'airport', 'baseball_diamond', 'basketball_court', 'beach', 'bridge', 'chaparral', 'church', 'circular_farmland', 'cloud', 'commercial_area', 'dense_residential', 'desert', 'forest', 'freeway'};
opt.type = {'sift'};
%matching
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_sift_el1=f;
            d_sift_el1=d;
            continue;
        end
        disp(j);
    end
    f_sift_el1=[f_sift_el1,f];
    d_sift_el1=[d_sift_el1,d];
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_dsft_el1=f;
            d_dsft_el1=d;
            continue;
        end
        f_dsft_el1=[f_dsft_el1,f];
        d_dsft_el1=[d_dsft_el1,d];
        disp(j);
    end
end
opt.type = {'sift'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=20:40
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 20
            f_sift_el2=f;
            d_sift_el2=d;
            continue;
        end
        f_sift_el2=[f_sift_el2,f];
        d_sift_el2=[d_sift_el2,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=5:10
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 5
            f_dsft_el2=f;
            d_dsft_el2=d;
            continue;
        end
        f_dsft_el2=[f_dsft_el2,f];
        d_dsft_el2=[d_dsft_el2,d];
        disp(j);
    end
end
disp('READING ENDED');
%MATCHING_PAIRS
%Q2
kd=[24]; nc=[64];
%load data/hw2_data1.mat; 
%https://www.vlfeat.org/overview/encodings.html
[fv_gmm_sift_el1, A_sift_el1, fv_gmm_dsft_el1, A_dsft_el1,  fv_gmm_sift_el2, A_sift_el2, fv_gmm_dsft_el2, A_dsft_el2]=getFisherVectorModel(d_sift_el1,d_dsft_el1,d_sift_el2,d_dsft_el2, kd, nc);

%is called from aggregation in Q3, don't uncomment!!! 
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'sift');
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'dsft');


%Q3
disp('GMM CREATED');

 getVladAggregation( d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd, nc);

fv = getFisherVectorAggregation(d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd,nc);
disp('AGGREGATION FINISHED');

%Q4
load data/fisher_vector.mat; 
element1 = load('data/vlad_data_el1.mat'); 
element2 = load('data/vlad_data_el2.mat'); 





%all vectors
%https://www.vlfeat.org/overview/plots-rank.html
enc1 = encoding1_sift;
enc2 = encoding2_sift;
enc3 = encoding1_dsft;
enc4 = encoding2_dsft;

fisherVectorSift1 = reshape(enc1(:), 24, []).';
fisherVectorSift2 = reshape(enc2(:), 24, []).';
fisherVectorDSFT1 = reshape(enc3(:), 24, []).';
fisherVectorDSFT2 = reshape(enc4(:), 24, []).';
figure(1);
vl_roc(fisherVectorSift1, fisherVectorSift2) ;
figure(2);
vl_pr(fisherVectorSift1, fisherVectorSift2) ;
figure(3);
vl_det(fisherVectorSift1, fisherVectorSift2) ;
figure(4);
vl_roc(fisherVectorDSFT1, fisherVectorDSFT2) ;
figure(5);
vl_pr(fisherVectorDSFT1, fisherVectorDSFT2) ;
figure(6);
vl_det(fisherVectorDSFT1, fisherVectorDSFT2) ;


vladVectorSift1 = reshape(element1.vlad_km_sift(:), 4, []).';
vladVectorSift2 = reshape(element2.vlad_km_sift(:), 4, []).';
vladVectorDSFT1 = reshape(element1.vlad_km_dsft(:), 4, []).';
vladVectorDSFT2 = reshape(element2.vlad_km_dsft(:), 4, []).';

%all euclidean distances
%https://www.mathworks.com/help/stats/pdist2.html#d122e588563
distanceVladSIFT = pdist2(vladVectorSift1,vladVectorSift2,'euclidean');

distanceVladDSFT = pdist2(vladVectorDSFT1,vladVectorDSFT2,'euclidean');
figure(7);
vl_roc(vladVectorSift1, vladVectorSift2) ;
figure(8);
vl_pr(vladVectorSift1, vladVectorSift2) ;
figure(9);
vl_det(vladVectorSift1, vladVectorSift2) ;
figure(10);
vl_roc(vladVectorDSFT1, vladVectorDSFT2) ;
figure(11);
vl_pr(vladVectorDSFT1, vladVectorDSFT2) ;
figure(12);
vl_det(vladVectorDSFT1, vladVectorDSFT2) ;

distanceFishingVectorSIFT = pdist2(fisherVectorSift1,fisherVectorSift2,'euclidean');
distanceFishingVectorDSFT = pdist2(fisherVectorDSFT1,fisherVectorDSFT2,'euclidean');
getPrecisionRecall(distanceVladSIFT, distanceVladDSFT, 32, 13, 14);
getPrecisionRecall(distanceFishingVectorSIFT, distanceFishingVectorDSFT, 32,15,16);

end;

%NON_MATCHING_PAIRS
if matching == 0
classes = {'airplane', 'airport', 'baseball_diamond', 'basketball_court', 'beach', 'bridge', 'chaparral', 'church', 'circular_farmland', 'cloud', 'commercial_area', 'dense_residential', 'desert', 'forest', 'freeway'};
opt.type = {'sift'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_sift_el1=f;
            d_sift_el1=d;
            continue;
        end
        f_sift_el1=[f_sift_el1,f];
        d_sift_el1=[d_sift_el1,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=1:length(classes)
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 1 && j == 1
            f_dsft_el1=f;
            d_dsft_el1=d;
            continue;
        end
        f_dsft_el1=[f_dsft_el1,f];
        d_dsft_el1=[d_dsft_el1,d];
        disp(j);
    end
end
opt.type = {'sift'};
for i=length(classes):-1:1
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:20
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 15 && j == 1
            f_sift_el2=f;
            d_sift_el2=d;
            continue;
        end
        f_sift_el2=[f_sift_el2,f];
        d_sift_el2=[d_sift_el2,d];
        disp(j);
    end
end
opt.type = {'dsft'};
for i=length(classes):-1:1
    folder = sprintf('NWPU-RESISC45\\NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:5
        img=single(rgb2gray(imread([folder '\' images(j).name])));
        [f,d] = getImageFeatures(img, opt);
        if i == 15 && j == 1
            f_dsft_el2=f;
            d_dsft_el2=d;
            continue;
        end
        f_dsft_el2=[f_dsft_el2,f];
        d_dsft_el2=[d_dsft_el2,d];
        disp(j);
    end
end
disp('READING ENDED');

%Q2
kd=[24]; nc=[64];
%load data/hw2_data2.mat; 
%https://www.vlfeat.org/overview/encodings.html
[fv_gmm_sift_el1, A_sift_el1, fv_gmm_dsft_el1, A_dsft_el1,  fv_gmm_sift_el2, A_sift_el2, fv_gmm_dsft_el2, A_dsft_el2]=getFisherVectorModel(d_sift_el1,d_dsft_el1,d_sift_el2,d_dsft_el2, kd, nc);

%is called from aggregation in Q3, don't uncomment!!! 
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'sift');
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'dsft');

disp('GMM CREATED');

%Q3

 getVladAggregation( d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd, nc);

fv = getFisherVectorAggregation(d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2,A_sift_el1,A_dsft_el1,A_sift_el2,A_dsft_el2, kd,nc, fv_gmm_sift_el1,fv_gmm_dsft_el1,fv_gmm_sift_el2,fv_gmm_dsft_el2);
disp('AGGREGATION FINISHED');

%Q4
load data/fisher_vector.mat; 
element1 = load('data/vlad_data_el1.mat'); 
element2 = load('data/vlad_data_el2.mat'); 





%all vectors
%https://www.vlfeat.org/overview/plots-rank.html
enc1 = encoding1_sift;
enc2 = encoding2_sift;
enc3 = encoding1_dsft;
enc4 = encoding2_dsft;

fisherVectorSift1 = reshape(enc1(:), 24, []).';
fisherVectorSift2 = reshape(enc2(:), 24, []).';
fisherVectorDSFT1 = reshape(enc3(:), 24, []).';
fisherVectorDSFT2 = reshape(enc4(:), 24, []).';
figure(1);
vl_roc(fisherVectorSift1, fisherVectorSift2) ;
figure(2);
vl_pr(fisherVectorSift1, fisherVectorSift2) ;
figure(3);
vl_det(fisherVectorSift1, fisherVectorSift2) ;
figure(4);
vl_roc(fisherVectorDSFT1, fisherVectorDSFT2) ;
figure(5);
vl_pr(fisherVectorDSFT1, fisherVectorDSFT2) ;
figure(6);
vl_det(fisherVectorDSFT1, fisherVectorDSFT2) ;


vladVectorSift1 = reshape(element1.vlad_km_sift(:), 4, []).';
vladVectorSift2 = reshape(element2.vlad_km_sift(:), 4, []).';
vladVectorDSFT1 = reshape(element1.vlad_km_dsft(:), 4, []).';
vladVectorDSFT2 = reshape(element2.vlad_km_dsft(:), 4, []).';

%all euclidean distances
%https://www.mathworks.com/help/stats/pdist2.html#d122e588563
distanceVladSIFT = pdist2(vladVectorSift1,vladVectorSift2,'euclidean');

distanceVladDSFT = pdist2(vladVectorDSFT1,vladVectorDSFT2,'euclidean');
figure(7);
vl_roc(vladVectorSift1, vladVectorSift2) ;
figure(8);
vl_pr(vladVectorSift1, vladVectorSift2) ;
figure(9);
vl_det(vladVectorSift1, vladVectorSift2) ;
figure(10);
vl_roc(vladVectorDSFT1, vladVectorDSFT2) ;
figure(11);
vl_pr(vladVectorDSFT1, vladVectorDSFT2) ;
figure(12);
vl_det(vladVectorDSFT1, vladVectorDSFT2) ;

distanceFishingVectorSIFT = pdist2(fisherVectorSift1,fisherVectorSift2,'euclidean');
distanceFishingVectorDSFT = pdist2(fisherVectorDSFT1,fisherVectorDSFT2,'euclidean');
getPrecisionRecall(distanceVladSIFT, distanceVladDSFT, 32, 13, 14);
getPrecisionRecall(distanceFishingVectorSIFT, distanceFishingVectorDSFT, 32,15,16);
end;



