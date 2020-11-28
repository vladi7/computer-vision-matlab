function [A0, eigv] = getEigenfacemodel(faces, plotting)
[A1, ~, lat]=pca(faces);
kd = 64;
A0 = A1(:,1:kd);
eigv = lat(1:kd);
%eigen values
if plotting == 1
    figure(11);
    subplot(1,2,1); grid on; hold on; stem(lat, '.');
    f_eng=lat.*lat;
    subplot(1,2,2); grid on; hold on;
    plot(cumsum(f_eng)/sum(f_eng), '.-');
    figure(12);
    for k=1:kd
        subplot(8,8,k);
        colormap('gray'); imagesc(reshape(A1(:,k), [20, 20]));
        title(sprintf('eigf_%d', k));
    end
    figure(13)
    plot(real(lat),imag(lat),'r*')
    xlabel('Real')
    ylabel('Imaginary')
    t1 = ['Eigenvalues'];
    title(t1)
    display(["information/energy lost: " sum(lat(kd:end))]);
end
end

