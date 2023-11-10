% Define data
values = [10, 20];
colors = {'r', 'b'}; % Use 'r' for red and 'b' for blue

% Create bar chart
b = bar(values);
b.FaceColor = 'flat';
b.CData(1,:) = centers(4,:)/255;


% Add labels and title
xlabel('Bars');
ylabel('Values');
title('Custom Bar Chart');

% Add legend
legend('Bar 1', 'Bar 2');
