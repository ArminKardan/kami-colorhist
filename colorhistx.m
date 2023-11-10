% Read the image
img = imread('1.jpg'); % replace 'your_image.jpg' with the actual image file

% Reshape the image to a 2D array of RGB values
img_vector = double(reshape(img, [], 3));

% Specify the number of clusters (5 in this case)
k = 5;
major_remove = 1;
normalize = 0;

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

b = bar(1:l, pixel_count);
if normalize==1
    b = bar(1:l, pixel_count/sum(pixel_count));
end


b.FaceColor = 'flat';
for i=1:length(pixel_count)
   b.CData(i,:) = myMap(num2str(pixel_count(i)));
end
title('Pixel Count for Each Cluster Center');
xlabel('Cluster Center');
ylabel('Pixel Count');


% Create a cell array to store legend entries
legend_entries = cell(1, 1);

% Create the bar chart and store its handle
hold on;  % Turn on hold to add multiple bars to the same figure
b = bar(1:l, pixel_count);

% Optionally, normalize the pixel counts
if normalize == 1
    pixel_count = pixel_count / sum(pixel_count);
end

% Set the colors of the bars based on the associated color in myMap
b.FaceColor = 'flat';
for i = 1:l
    b.CData(i, :) = myMap(num2str(pixel_count(i)));
    
    % Create a legend entry for each bar
    legend_entries{i} = ['Count: ' num2str(pixel_count(i))];
end

% Create the bar chart and store its handle
hold on;  % Turn on hold to add multiple bars to the same figure
b = bar(1:l, pixel_count);

% Optionally, normalize the pixel counts
if normalize == 1
    pixel_count = pixel_count / sum(pixel_count);
end

% Set the colors of the bars based on the associated color in myMap
b.FaceColor = 'flat';
for i = 1:l
    b.CData(i, :) = myMap(num2str(pixel_count(i)));
    
    % Create a legend entry for each bar
    legend_entries{i} = ['Count: ' num2str(pixel_count(i))];
end

% hold on;  % Turn on hold to add multiple bars to the same figure
b = bar(1:l, pixel_count);

% Optionally, normalize the pixel counts
if normalize == 1
    pixel_count = pixel_count / sum(pixel_count);
end

% Set the colors of the bars based on the associated color in myMap
b.FaceColor = 'flat';
st = [0];
for i = 1:l
    b.CData(i, :) = myMap(num2str(pixel_count(i)));
    plot(st,st,'Color', [1,0,0]);
    % Create a legend entry for each bar
    legend_entries{i} = ['Count: ' num2str(pixel_count(i))];
end


% Add the legend with individual entries
legend(legend_entries);

% Set chart properties (title, labels, etc.)
title('Pixel Count for Each Cluster Center');
xlabel('Cluster Center');
ylabel('Pixel Count');

