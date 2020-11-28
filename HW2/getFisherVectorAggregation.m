% f - n x d matrix containing a feature from an image by calling f=getImageFeature(im,.. 
% fv_gmm - GMM Model from features, has m, cov, and p. 
function [encoding1_sift, encoding2_sift,encoding1_dsft, encoding2_dsft] = getFisherVectorAggregation(d_sift_el1, d_dsft_el1, d_sift_el2, d_dsft_el2, kd, nc)

load data/gmm_data1.mat; 

for j=1:length(kd)
    for k =1:length(nc)
        x = double(d_sift_el1)*A_sift_el1(:,1:kd(j));
        if k ==1 && j == 1
        encoding_temp = vl_fisher(x', fv_gmm_sift_el1(j,k).m, fv_gmm_sift_el1(j,k).cov, fv_gmm_sift_el1(j,k).p);
        encoding1_sift = encoding_temp';
        continue;
        end
        encoding_temp = vl_fisher(x', fv_gmm_sift_el1(j,k).m, fv_gmm_sift_el1(j,k).cov, fv_gmm_sift_el1(j,k).p);
        encoding1_sift = [encoding1_sift,encoding_temp'];
    end
end


for j=1:length(kd)
    for k =1:length(nc)
        x = double(d_dsft_el1)*A_dsft_el1(:,1:kd(j));
        if k ==1 && j == 1
        encoding_temp = vl_fisher(x', fv_gmm_dsft_el1(j,k).m, fv_gmm_dsft_el1(j,k).cov, fv_gmm_dsft_el1(j,k).p);
        encoding1_dsft = encoding_temp';
        continue;
        end
        encoding_temp = vl_fisher(x', fv_gmm_dsft_el1(j,k).m, fv_gmm_dsft_el1(j,k).cov, fv_gmm_dsft_el1(j,k).p);
        encoding1_dsft = [encoding1_dsft,encoding_temp'];
    end
end

for j=1:length(kd)
    for k =1:length(nc)
        x = double(d_sift_el2)*A_sift_el2(:,1:kd(j));
        if k ==1 && j == 1
        encoding_temp = vl_fisher(x', fv_gmm_sift_el2(j,k).m, fv_gmm_sift_el2(j,k).cov, fv_gmm_sift_el2(j,k).p);
        encoding2_sift = encoding_temp';
        continue;
        end
        encoding_temp = vl_fisher(x', fv_gmm_sift_el2(j,k).m, fv_gmm_sift_el2(j,k).cov, fv_gmm_sift_el2(j,k).p);
        encoding2_sift = [encoding2_sift,encoding_temp'];
    end
end


for j=1:length(kd)
    for k =1:length(nc)
        x = double(d_dsft_el2)*A_dsft_el2(:,1:kd(j));
        if k ==1 && j == 1
        encoding_temp = vl_fisher(x', fv_gmm_dsft_el2(j,k).m, fv_gmm_dsft_el2(j,k).cov, fv_gmm_dsft_el2(j,k).p);
        encoding2_dsft = encoding_temp';
        continue;
        end
        encoding_temp = vl_fisher(x', fv_gmm_dsft_el2(j,k).m, fv_gmm_dsft_el2(j,k).cov, fv_gmm_dsft_el2(j,k).p);
        encoding2_dsft = [encoding2_dsft,encoding_temp'];
    end
end

save 'data/fisher_vector.mat' encoding1_sift encoding2_sift encoding1_dsft encoding2_dsft '-v7.3';


end

