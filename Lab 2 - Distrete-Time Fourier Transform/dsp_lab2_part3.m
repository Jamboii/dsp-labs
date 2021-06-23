w = (0:1023)*2*pi/1024;
alpha = 0.95;
mag_dtft = sqrt(1 ./ (1./alpha.^2 - (2./alpha * cos(w)) + 1));

figure
plot(w,mag_dtft)
xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])
xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'})
title('X(e^{j\omega})')
ylim([0 20])
xlim([0 (2*pi)])