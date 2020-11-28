function []=KMeansSinglePicture(path)

images = imread(path);
[h, bins] = getHSVHist(images);

figure(1); 
subplot(1,3,1); imshow(images); 
subplot(1,3,2); bar(h); grid on; 
subplot(1,3,3); plot3(bins(:,1), bins(:,2), bins(:,3), '*'); grid on;
xlabel('H'); ylabel('S'); xlabel('V');

return;


