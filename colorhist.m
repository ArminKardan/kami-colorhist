clear all;
close all;
clc;

% Read the image
img = imread('1.jpg'); % replace 'your_image.jpg' with the actual image file

% Reshape the image to a 2D array of RGB values
img_vector = double(reshape(img, [], 3));

% Specify the number of clusters (5 in this case)
k = 5;
major_remove = 1;
normalize = 1;

% Perform K-Means clustering
[idx, centers] = kmeans(img_vector, k, 'Start', zeros(k, size(img_vector, 2)));

% Initialize a variable to store the count of pixels for each cluster
pixel_count = zeros(k, 1);

for i = 1:k
    % Find the indices of pixels belonging to each cluster
    cluster_indices = find(idx == i);
    
    % Update the pixel count for this cluster
    pixel_count(i) = length(cluster_indices);
end


myMap = containers.Map;
for i=1:length(centers)
    myMap(num2str(pixel_count(i))) = centers(i,:)/255; 
end


pixel_count = sort(pixel_count);

l = k;
if major_remove == 1
    l = k - 1;
    pixel_count(k,:) = [];
end


b = [];

hold on;
for i=1:l
  br = bar([i], pixel_count(i),'FaceColor',  myMap(num2str(pixel_count(i))));
end
hold off;


title('Pixel Count for Each Cluster Center');
xlabel('Cluster Center');
ylabel('Pixel Count');
legs = cell(1, 1);
for i=1:l
    legs{i} = [sprintf('%i - %i',(i - 1)*100, (i)*100)];
end
legend(legs);
