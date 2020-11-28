%function [A, v]=getLDA(x, y)
function [A, v]=getLDA(x, y)
dbg=0;
if dbg
    load data/pca-faces-ids.mat;
    y = ids(1:400);  x=x(1:400,:);
end

[n, kd]=size(x); 

% compute class mean
mx = mean(x);  
ids = unique(y); m = length(ids);
Sb = zeros(kd, kd); 
for k=1:m
    indx = find(y==ids(k)); nk(k) = length(indx); 
    % class mean
    m_cx(k,:) = mean(x(indx, :));
    % between class scatter
    Sb = Sb + nk(k)*(m_cx(k,:) - mx)'*(m_cx(k,:) - mx);
end

% compute intra-class scatter
Sw = zeros(kd, kd); 
for k=1:m
    indx = find(y==ids(k)); nk(k) = length(indx); 
    % remove mean
    xk = x(indx, :) - repmat(m_cx(k,:), [nk(k), 1]);
    % adding up
    Sw = Sw + (xk'*xk);
end

% solve by generalized eigen problem
[A, v]=eigs(Sb, Sw); 

if dbg
    figure(31); 
    subplot(2,2,1); imagesc(Sb); colormap('gray'); title('S_b'); 
    subplot(2,2,2); imagesc(Sw); colormap('gray'); title('S_w'); 
    
    z = x*A;  dist = pdist2(z, z); 
    subplot(2,2,3); imagesc(dist); title('dist(j,k)');
    subplot(2,2,4); stem(diag(v), '.'); grid on; hold on;  title('eig v');
end

return;
