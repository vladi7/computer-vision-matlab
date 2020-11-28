function [tp, fp, tn, fn]=getPrecisionRecall(d0, d1, npt)


d_min = min(min(d0), min(d1));
d_max = max(max(d0), max(d1));

delta = (d_max - d_min) / npt;

for k=1:npt
    thres = d_min + (k-1)*delta;
    tp(k) = length(find(d0<=thres));
    fp(k) = length(find(d1<=thres));
    tn(k) = length(find(d1>thres));
    fn(k) = length(find(d0>thres));   
end

%     figure(1); grid on; hold on;
    %plotHist(d0, 40); plotHist(d1, 40); 
    %https://www.mathworks.com/help/matlab/ref/matlab.graphics.chart.primitive.histogram.html
    %https://developers.google.com/machine-learning/crash-course/classification/precision-and-recall
%      histogram(d0,40);histogram(d1,40);
%     figure(2); grid on; hold on;
%     plot(fp./(tn+fp), tp./(tp+fn), '.-r', 'DisplayName', 'tpr-fpr');
%     plot(tp./(tp+fn), tp./(tp+fp), '.-k', 'DisplayName', 'precision-recall');   
%     legend();

return;

