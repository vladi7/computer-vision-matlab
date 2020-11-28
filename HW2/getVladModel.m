% f - n x d matrix containing training features from say 100 images. 
% k - VLAD kmeans model number of cluster 
% kd - desired dimension of the feature 
% vlad_km - VLAD kmeans model
% A - PCA projection for dimension reduction
function [nn_sift,centers_sift, nn_dsft,centers_dsft]= getVladModel(dataSift,dataDSFT, k, mode)
% PCA dimension reduction of the feature
%https://www.vlfeat.org/overview/encodings.html

numClusters = k;
if mode == 'sift'
nn_dsft = 1;
centers_dsft = 1;
centers_sift = vl_kmeans(double(dataSift), numClusters);
kdtree = vl_kdtreebuild(centers_sift) ;
nn_sift = vl_kdtreequery(kdtree, centers_sift, double(dataSift)) ;
end
if mode == 'dsft'
    nn_sift = 1;
centers_sift = 1;
centers_dsft = vl_kmeans(double(dataDSFT), numClusters);
kdtree = vl_kdtreebuild(centers_dsft) ;
nn_dsft = vl_kdtreequery(kdtree, centers_dsft, double(dataDSFT)) ;
end
end