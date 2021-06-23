
Yf = fft(y,N);

% stem of abs of entire result of fft
figure                                % new figure window
stem(n,abs(Yf),'filled','MarkerSize', 2)                % 1 plot
xlabel('Index n')                     % label the x-axis
title(sprintf('do the fft'))          % title the figure
xlim([0 N-1])                         % define the x-axis limits

% first 128 samples of fft
figure
stem(1:128, abs(Yf(1:128)),'filled','MarkerSize',2)     % nice stem plot of x
xlabel('Index n')                     % label the x-axis
title(sprintf('do the fft but smaller'))          % title the figure
xlim([0 N/2-1])                         % define the x-axis limits

% plot real and imaginary components
real_Yf = real(Yf(1:128));
imag_Yf = imag(Yf(1:128));

figure
stem(real_Yf,'bo')
title('real?')
xlim([0 N/2-1])

figure
stem(imag_Yf,'bo')
title('imaginary?')
xlim([0 N/2-1])