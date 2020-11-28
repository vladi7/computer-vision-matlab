
function []=ClassifyNearestNeighbors(K,classes)

table = zeros(400,prod([256,256,3]));
randomVector = randperm(1500,400);
counter1=1;
counter2=1;
for i=1:length(classes)    
    folder = sprintf('NWPU-RESISC45\\%s', classes{i});
    disp(folder)
    images = dir([folder '\*.jpg']);
    for j=1:100
        if ~ismember(counter1,randomVector)
        counter1 = counter1+1;
        continue
        end
        img = rgb2hsv(imread([folder '\' images(j).name]));
        table(counter2,:) = img(:); 
        classLabels(counter2,:) = classes(i); 
        counter1 = counter1+1;
        counter2 = counter2+1;
    end
end  


Mdl = fitcknn(table,classLabels,'NumNeighbors',K,'Standardize',1);
disp(Mdl)
predictedLabels = resubPredict(Mdl);
cp = classperf(classLabels,predictedLabels);
disp(cp.CorrectRate);
figure(2); 
ch = confusionchart(classLabels,predictedLabels);
disp(ch);
return;


