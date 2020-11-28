% f - n x d matrix containing n features from say 100 images.
% k - number of GMM components
% kd - desired lower dimension of the feature
% fv_gmm - FisherVector GMM model:
%         fv_gmm.m - mean, fv_gmm.cov - variance, fv_gmm.p - prior
% A - PCA for dimension reduction
function getFisherVectorModel(d_sift_el1,d_dsft_el1,d_sift_el2,d_dsft_el2, kd, nc)
[A_sift_el1,s,lat]=pca(double(d_sift_el1));
t0=cputime;
for j=1:length(kd)
    for k =1:length(nc)
        fprintf('\n t=%1.2f: GMM: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), k, nc(k));
        x = double(d_sift_el1)*A_sift_el1(:,1:kd(j));
        [fv_gmm_sift_el1(j,k).m, fv_gmm_sift_el1(j,k).cov, fv_gmm_sift_el1(j,k).p]=vl_gmm(x', nc(k), 'MaxNumIterations', 30);
    end
end

[A_dsft_el1,s,lat]=pca(double(d_dsft_el1));
t0=cputime;
for j=1:length(kd)
    for k =1:length(nc)
        fprintf('\n t=%1.2f: GMM: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), k, nc(k));
        x = double(d_dsft_el1)*A_dsft_el1(:,1:kd(j));
        [fv_gmm_dsft_el1(j,k).m, fv_gmm_dsft_el1(j,k).cov, fv_gmm_dsft_el1(j,k).p]=vl_gmm(x', nc(k), 'MaxNumIterations', 30);
    end
end

[A_sift_el2,s,lat]=pca(double(d_sift_el2));
t0=cputime;
for j=1:length(kd)
    for k =1:length(nc)
        fprintf('\n t=%1.2f: GMM: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), k, nc(k));
        x = double(d_sift_el2)*A_sift_el2(:,1:kd(j));
        [fv_gmm_sift_el2(j,k).m, fv_gmm_sift_el2(j,k).cov, fv_gmm_sift_el2(j,k).p]=vl_gmm(x', nc(k), 'MaxNumIterations', 30);
    end
end

[A_dsft_el2,s,lat]=pca(double(d_dsft_el2));
t0=cputime;
for j=1:length(kd)
    for k =1:length(nc)
        fprintf('\n t=%1.2f: GMM: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), k, nc(k));
        x = double(d_dsft_el2)*A_dsft_el2(:,1:kd(j));
        [fv_gmm_dsft_el2(j,k).m, fv_gmm_dsft_el2(j,k).cov, fv_gmm_dsft_el2(j,k).p]=vl_gmm(x', nc(k), 'MaxNumIterations', 30);
    end
end
save 'data/gmm_data1.mat' fv_gmm_sift_el1 A_sift_el1 fv_gmm_dsft_el1 A_dsft_el1  fv_gmm_sift_el2 A_sift_el2 fv_gmm_dsft_el2 A_dsft_el2 '-v7.3';
end

