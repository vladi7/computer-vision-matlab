function [histogram,centroids]=getHSVHist(image)

image = rgb2hsv(image);
[height, width, dimensions]=size(image);
matrix = double(reshape(image, [width*height, dimensions]));
[~, centroids]=kmeans(matrix, 64);
[m_dimension_size, ~]=size(centroids);
distance = pdist2(matrix, centroids);
[~, pixel_centroids_offsets]=min(distance');
histogram = zeros(m_dimension_size);

for counter=1:m_dimension_size
    histogram(counter) = length(find(pixel_centroids_offsets == counter));
end

histogram = histogram/sum(histogram);


return;
