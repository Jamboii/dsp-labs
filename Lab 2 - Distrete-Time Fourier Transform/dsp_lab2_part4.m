
N = 1024;
Xf = fft(x,N);

subplot(2,1,1); plot((0:1023)*2*pi/1024,abs(Xf)) % 2 subplots, stacked vert

xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])        % set ticks to be pi-ish
xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'}) % pi-ish labels
title('Xf(e^{j\omega}) (MATLAB)')                        % set title
ylim([0 20])                                    % set vertical axis limits
xlim([0 (2*pi)])                                % set horizontal axis limits

subplot(2,1,2); plot((0:1023)*2*pi/1024,mag_dtft)
xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])
xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'})
title('X(e^{j\omega}) (MANUAL)')
ylim([0 20])
xlim([0 (2*pi)])

% FFT of truncated sequence seems to match the DTFT of the infinite length
% sequence wow, why do we think that is????