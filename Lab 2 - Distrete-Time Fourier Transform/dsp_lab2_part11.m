N = 16;
w = double(0:0.01:2*pi);

mag_sin = sin(w*N/2);
Wf = abs(mag_sin) ./ sin(w/2);

plot(w,abs(Wf)) % 2 subplots, stacked vert

xticks([0 pi 2*pi])             % set ticks to be pi-ish
xticklabels({'0','\pi','2\pi'}) % pi-ish labels
title('|Wf(e^{j\omega})| (MATLAB)')                        % set title
ylim([0 20])                                    % set vertical axis limits
xlim([0 (2*pi)])                                % set horizontal axis limits