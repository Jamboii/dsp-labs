% Create a test signal of sum of two sampled cosine waves in cont. time
Fs = 1;             % sampling frequency
N  = 200000;           % # of samples
f1 = 10.5 * Fs / N; % frequency 1
f2 = 16   * Fs / N; % frequency 2

t = 0:N-1;          % time series

f = cos(2*pi*f1*t) + 0.01*cos(2*pi*f2*t); % combined signal x[n]
noise = wgn(1,N,-20);                     % white gaussian noise
f = f + noise;                            % add noise to signal

% Plot 200 samples of the waveform
figure(1);
subplot(211); plot(t,f);
title('f(t)');

% Compute FFT
fft_rec = fft(f);
fft_rec_dB = 20*log10(abs(fft_rec(1:100)));
fft_rec_dB = fft_rec_dB - max(fft_rec_dB);

% Plot FFT magnitude in dB vs. bin number for bins 0-100
subplot(212); plot(t(1:100),fft_rec_dB);
ylim([-70 0])
xlim([0 100])
title('|F(e^j^*^w)| - Rectangular Window');
xlabel('Index n');
ylabel('Power (dB)');

% rectangle window stuff
window_rec = rectwin(N);

% Get windows for low- and high-performing window functions
window_triang = triang(N);
window_kaiser = kaiser(N, 2.5*pi);

% Find fft of window functions
fft_triang = fft(f .* window_triang');
fft_kaiser = fft(f .* window_kaiser');

% Convert triangle window fft to dB
fft_triang_dB = 20*log10(abs(fft_triang));
% Normalize dB to match the paper
fft_triang_dB = fft_triang_dB - max(fft_triang_dB);

% Convert kaiser window fft to dB
fft_kaiser_dB   = 20*log10(abs(fft_kaiser));
% Normalize dB to match the paper
fft_kaiser_dB = fft_kaiser_dB - max(fft_kaiser_dB);

figure(2);
% subplot(211); plot(t(1:100),fft_triang_dB(1:100));
plot(t(1:100),fft_triang_dB(1:100));
title('|F(e^j^*^w)| - Triangle Window');
ylim([-70 0])
xlim([0 100])
xlabel('Index n');
ylabel('Power (dB)');

% window func
% subplot(212); plot(t, window_triang');

% log mag of window fft
fft_win_triang = fft(window_triang');
fft_win_triang_dB = abs(fft_win_triang);

% subplot(313); plot(t, fft_win_triang_dB);

figure(3);
% subplot(212); plot(t(1:100),fft_kaiser_dB(1:100));
plot(t(1:100),fft_kaiser_dB(1:100));
title('|F(e^j^*^w)| - Kaiser-Bessel Window');
ylim([-70 0])
xlim([0 100])
xlabel('Index n');
ylabel('Power (dB)');

% show kaiser and other eqs
% take fft of that func and shows what we're gonna concolve with 