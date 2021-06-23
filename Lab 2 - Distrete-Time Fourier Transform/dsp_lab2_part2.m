NUM_SAMPS = 200;
t = double(0:NUM_SAMPS-1);
alpha = 0.95;
x = alpha.^t;

figure                                % new figure window
stem(t,x,'filled','MarkerSize',2)     % nice stem plot of x
xlabel('Index n')                     % label the x-axis
title(sprintf( '%0.2f^n', alpha))     % title the figure
xlim([0 200])                         % define the x-axis limits