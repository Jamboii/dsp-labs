% N = 256;
t = double(0:N-1)/N;
% F(s) = 256 Hz
% 0 <= t < 1 sec

y5 = cos(23*pi*t);                                  % exactly 11.5 cycles
Fy = fft(y5);                                       % take the FFT
subplot(2,1,1)                                      % stack 2 vertical, 1st
stem(0:(N/2-1),abs(Fy(1:N/2)),'filled','MarkerSize',2) % plot N-point FFT
xlim([0 128])                                       % set plot width
Fy_16 = fft(y5,N*16);                               % FFT with 4096 samples

subplot(2,1,2)                                      % stack 2 vertical, 2nd
plot(0:(16*N/2-1),abs(Fy_16(1:16*N/2)))             % line plot for detail
xlim([0 N*16/2])                                    % set plot width