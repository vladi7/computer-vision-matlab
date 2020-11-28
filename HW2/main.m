clear;
run ('vlfeat-0.9.20/toolbox/vl_setup');
vl_version verbose
load MPEG.CDVS/hw-2-data.mat; 
%Q1
getImagesFeatures();
%set to 0 for nonmatching
matching = 1;
if matching == 1
%MATCHING_PAIRS
%Q2
kd=[24,48]; nc=[32, 64, 96];
load data/hw2_data1.mat; 
%https://www.vlfeat.org/overview/encodings.html
getFisherVectorModel(d_sift_el1,d_dsft_el1,d_sift_el2,d_dsft_el2, kd, nc);

%is called from aggregation in Q3, don't uncomment!!! 
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'sift');
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'dsft');


%Q3

getVladAggregation( d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd, nc);

fv = getFisherVectorAggregation(d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd,nc);

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

%Q2
kd=[24,48]; nc=[32, 64, 96];
load data/hw2_data2.mat; 
%https://www.vlfeat.org/overview/encodings.html
getFisherVectorModel(d_sift_el1,d_dsft_el1,d_sift_el2,d_dsft_el2, kd, nc);

%is called from aggregation in Q3, don't uncomment!!! 
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'sift');
%[vlad_nn_sift,centers_sift, vlad_nn_dsft,centers_dsft] = getVladModel(d_sift, d_dsft, kd, 'dsft');


%Q3

getVladAggregation( d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd, nc);

fv = getFisherVectorAggregation(d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd,nc);

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


