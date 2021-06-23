hold on
plot(0:(16*N/2-1),abs(Fy_16(1:16*N/2)))             % line plot for detail
stem((0:(N/2-1))*16,abs(Fy(1:N/2)),'filled','MarkerSize',2) % plot N-point FFT
xlim([0 N*16/2])                                    % set plot width
hold off