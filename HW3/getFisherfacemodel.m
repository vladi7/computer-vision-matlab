function [A1] = getFisherfacemodel(faces, A0, ids, kd, plotting) 
n_face = length(faces);
%kd = 64;
[A1, ~]=getLDA(faces(1:n_face,:)*A0(:,1:kd),ids(1:n_face));
if plotting == 1
x1 = faces*A0(:,1:kd); 
x2 = faces*A0(:,1:kd)*A1; 
%disp(size(ids(1:n_face)));

f_dist2 = pdist2(x2(1:7,:), x2);
%avoiding singlularity
eigface = eye(400)*A0(:,1:kd);
fishface = eye(400)*A0(:,1:kd)*A1; 
for k=1:4
   figure(21);
   subplot(2,4,k); imagesc(reshape(eigface(:,k),[20, 20])); colormap('gray');
   title(sprintf('Eigf_%d', k)); 
   subplot(2,4,k+4); imagesc(reshape(fishface(:,k),[20, 20])); colormap('gray');
   title(sprintf('Fisherf_%d', k)); 
end

for k=1:4
   figure(22);
   subplot(2,4,k); 
   imagesc(reshape(fishface(:,k),[20, 20])); 
   colormap('gray');
   title(sprintf('fisherf_%d', k)); 
end
   figure(23);

d0 = f_dist2(1:7,1:7); d1=f_dist2(1:7, 8:end);
[tp, fp, tn, fn]= getPrecisionRecall(d0(:), d1(:), 40); 
   figure(24);

plot(fp./(tn+fp), tp./(tp+fn), '.-r', 'DisplayName', 'fisher kd=64');

end
end
