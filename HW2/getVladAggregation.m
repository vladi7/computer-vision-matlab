function getVladAggregation(dataSift, dataDSFT, dataSift2, dataDSFT2, kd, nc)

[A_sift,s,lat]=pca(double(dataSift));
t0=cputime;
globalCount = 1;
    for j=1:length(kd)
        for numClusters =1:length(nc)
            [nn_sift,centers_sift, ~,~] = getVladModel(dataSift,dataDSFT, numClusters, 'sift');
            numDataToBeEncoded = length(nn_sift);
            assignments_sift = zeros(numClusters,numDataToBeEncoded);
            assignments_sift(sub2ind(size(assignments_sift), nn_sift, 1:length(nn_sift))) = 1;
            fprintf('\n t=%1.2f: VLAD: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), numClusters, nc(numClusters));
            x = double(dataSift)*A_sift(:,1:kd(j));
            if globalCount==1
                vlad_km_sift_temp=vl_vlad(x, centers_sift,assignments_sift);
                vlad_km_sift = vlad_km_sift_temp';
                disp(size(vlad_km_sift));
                globalCount = globalCount + 1;
                continue;
            end         
             disp(1);
            disp(size(vlad_km_sift));
            disp(size(vlad_km_sift_temp));
            vlad_km_sift_temp=vl_vlad(x, centers_sift,assignments_sift);
            vlad_km_sift=[vlad_km_sift,vlad_km_sift_temp'];
            globalCount = globalCount + 1;
        end
    end
[A_dsft,s,lat]=pca(double(dataDSFT));
t0=cputime;
globalCount = 1;

for j=1:length(kd)
    for numClusters =1:length(nc)
        [~,~, nn_dsft,centers_dsft] = getVladModel(dataSift,dataDSFT, numClusters, 'dsft');
        numDataToBeEncoded = length(nn_dsft);
        assignments_dsft = zeros(numClusters,numDataToBeEncoded);
        assignments_dsft(sub2ind(size(assignments_dsft), nn_dsft, 1:length(nn_dsft))) = 1;
        fprintf('\n t=%1.2f: VLAD: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), numClusters, nc(numClusters));
        x = double(dataDSFT)*A_dsft(:,1:kd(j));
        if globalCount==1
            vlad_km_dsft_temp=vl_vlad(x, centers_dsft,assignments_dsft);
            vlad_km_dsft=vlad_km_dsft_temp';
            globalCount = globalCount + 1;
            continue;
        end
        vlad_km_dsft_temp=vl_vlad(x, centers_dsft,assignments_dsft);
        vlad_km_dsft=[vlad_km_dsft,vlad_km_dsft_temp'];
        globalCount = globalCount + 1;
    end
end
save 'data/vlad_data_el1.mat' vlad_km_sift vlad_km_dsft '-v7.3';

[A_sift,s,lat]=pca(double(dataSift2));
t0=cputime;
globalCount = 1;
    for j=1:length(kd)
        for numClusters =1:length(nc)
            [nn_sift,centers_sift, ~,~] = getVladModel(dataSift2,dataDSFT2, numClusters, 'sift');
            numDataToBeEncoded = length(nn_sift);
            assignments_sift = zeros(numClusters,numDataToBeEncoded);
            assignments_sift(sub2ind(size(assignments_sift), nn_sift, 1:length(nn_sift))) = 1;
            fprintf('\n t=%1.2f: VLAD: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), numClusters, nc(numClusters));
            x = double(dataSift2)*A_sift(:,1:kd(j));
            if globalCount==1
                vlad_km_sift_temp=vl_vlad(x, centers_sift,assignments_sift);
                vlad_km_sift = vlad_km_sift_temp';
                disp(size(vlad_km_sift));
                globalCount = globalCount + 1;
                continue;
            end         
             disp(1);
            disp(size(vlad_km_sift));
            disp(size(vlad_km_sift_temp));
            vlad_km_sift_temp=vl_vlad(x, centers_sift,assignments_sift);
            vlad_km_sift=[vlad_km_sift,vlad_km_sift_temp'];
            globalCount = globalCount + 1;
        end
    end
[A_dsft,s,lat]=pca(double(dataDSFT2));
t0=cputime;
globalCount = 1;

for j=1:length(kd)
    for numClusters =1:length(nc)
        [~,~, nn_dsft,centers_dsft] = getVladModel(dataSift,dataDSFT2, numClusters, 'dsft');
        numDataToBeEncoded = length(nn_dsft);
        assignments_dsft = zeros(numClusters,numDataToBeEncoded);
        assignments_dsft(sub2ind(size(assignments_dsft), nn_dsft, 1:length(nn_dsft))) = 1;
        fprintf('\n t=%1.2f: VLAD: kd(%d)=%d, nc(%d)=%d ', cputime-t0, j, kd(j), numClusters, nc(numClusters));
        x = double(dataDSFT2)*A_dsft(:,1:kd(j));
        if globalCount==1
            vlad_km_dsft_temp=vl_vlad(x, centers_dsft,assignments_dsft);
            vlad_km_dsft=vlad_km_dsft_temp';
            globalCount = globalCount + 1;
            continue;
        end
        vlad_km_dsft_temp=vl_vlad(x, centers_dsft,assignments_dsft);
        vlad_km_dsft=[vlad_km_dsft,vlad_km_dsft_temp'];
        globalCount = globalCount + 1;
    end
end




save 'data/vlad_data_el2.mat' vlad_km_sift vlad_km_dsft '-v7.3';


end

