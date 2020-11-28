function [histogramsMatrix]=getHistForManyPictures(numberOfPictures,classes)


for i=1:length(classes)    
    folder = sprintf('NWPU-RESISC45\\%s', classes{i});
    images = dir([folder '\*.jpg']);
    for j=1:numberOfPictures        
        image = imread([folder '\' images(j).name]);
        [histogram,~] = getHSVHist(image);
        histogramsMatrix(i*j,:) = histogram; 
    end
end  

return;
