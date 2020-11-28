clear;
load data/gmm_data1.mat; 
means = fv_gmm_sift_el1(1,1).m;
priors = fv_gmm_sift_el1(1,1).p;

figure(1); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(2); 
bar(priors); grid on;

means = fv_gmm_sift_el1(1,2).m;
priors = fv_gmm_sift_el1(1,2).p;

figure(3); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(4); 
bar(priors); grid on;

means = fv_gmm_sift_el1(2,1).m;
priors = fv_gmm_sift_el1(2,1).p;

figure(5); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(6); 
bar(priors); grid on;

means = fv_gmm_sift_el1(2,2).m;
priors = fv_gmm_sift_el1(2,2).p;

figure(7); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(8); 
bar(priors); grid on;

means = fv_gmm_sift_el1(1,3).m;
priors = fv_gmm_sift_el1(1,3).p;

figure(9); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(10); 
bar(priors); grid on;

means = fv_gmm_sift_el1(2,3).m;
priors = fv_gmm_sift_el1(2,3).p;

figure(11); 

plot3(means(:,1:11), means(:,12:22), means(:,22:32), '*'); grid on;
figure(12); 
bar(priors); grid on;