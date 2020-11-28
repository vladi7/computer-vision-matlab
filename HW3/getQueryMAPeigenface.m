function [meanAveragePrecision] = getQueryMAPeigenface(faces, trainIndexes, q, retrievedIDs, kd)
trainFace = faces(setdiff(1:size(faces), q), :);
[A0, ~]=getEigenfacemodel(trainFace,0);
x1 = trainFace*A0(:,1:kd);   
    for k=1:length(q)       
        dist = pdist2(faces(q(k),:)*A0(:,1:kd), x1); 
        [~, offsets]=sort(dist); 
        tp = length(find(trainIndexes(offsets(1,1:6))==retrievedIDs(k))==1);  
        averagePrecision(k) = tp/6;    
    end 
    meanAveragePrecision = mean(averagePrecision);
end

