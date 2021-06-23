NUM_SAMPS = 200;
t = double(0:NUM_SAMPS-1);
alpha = 0.95;
x = alpha.^t;

figure                                % new figure window

subplot(3,1,1); stem(t,x,'filled','MarkerSize',2)     % nice stem plot of x
xlabel('Index n')                     % label the x-axis
title(sprintf( '%0.2f^n', alpha))     % title the figure
xlim([0 200])                         % define the x-axis limits

Xf = fft(x); % Take FFT

subplot(3,1,2); plot(t,abs(Xf))       % 2 subplots, stacked vert
xlabel('Index n')
title('Fourier Transform')            % set title
ylim([0 20])                          % set vertical axis limits
xlim([0 200])                         % set horizontal axis limits

Xif = ifft(Xf); % Take IFFT

subplot(3,1,3); stem(t,Xif,'filled','MarkerSize',2) % nice stem plot of x
xlabel('Index n')                                   % label the x-axis
title(sprintf( 'Inverse Fourier Transform' ))       % title the figure
xlim([0 200])                                       % define the x-axis limits



