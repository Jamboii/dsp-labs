% part 6

N = 256;
n = double(0:N-1);

y1 = sin(2*pi*n/N);
y2 = cos(4*pi*n/N);
y3 = cos(22*pi*n/N);
y4 = cos(202*pi*n/N);

y = y1 + y2 + y3 + y4;

figure                                % new figure window
stem(n,y,'filled','MarkerSize',2)     % nice stem plot of x
xlabel('Index n')                     % label the x-axis
title(sprintf('sum of vectors'))          % title the figure
xlim([0 N-1])                         % define the x-axis limits
