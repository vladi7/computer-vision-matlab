function [A2, eigv2] = getLaplacianfacemodel(faces, A0, ids, kd, plotting)
[A1, S, ~]=pca(faces);
%LPP
n_face = length(faces);
% eigenface
x1 = faces(1:n_face,:)*A1(:,1:kd); ids=ids(1:n_face);
% LPP - compute affinity
f_dist1 = pdist2(x1, x1);
% heat kernel size
mdist = mean(f_dist1(:)); h = -log(0.15)/mdist;
S1 = exp(-h*f_dist1);
if plotting == 1
    figure(32); subplot(2,2,1); imagesc(f_dist1); colormap('gray'); title('d(x_i, d_j)');
    subplot(2,2,2); imagesc(S1); colormap('gray'); title('affinity');
    subplot(2,2,3); grid on; hold on; [h_aff, v_aff]=hist(S(:), 40); plot(v_aff, h_aff, '.-');
end
% utilize supervised info
id_dist = pdist2(ids, ids);
if plotting == 1
    subplot(2,2,3); imagesc(id_dist); title('label distance');
end
S2=S1; S2(find(id_dist~=0)) = 0;
if plotting == 1
    subplot(2,2,4); imagesc(S1); colormap('gray'); title('affinity-supervised');
end
% laplacian face
lpp_opt.PCARatio = 1;
[A2, eigv2]=LPP(S2, lpp_opt, x1);
end

