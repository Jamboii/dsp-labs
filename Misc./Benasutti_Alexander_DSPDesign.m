% Analog signal is to be discretized by uniform sampling at a rate of Fs =
% 1kHz and then processed using a digital signal processor. Must meet
% certain design considerations
FT = 1500; % Sampling Frequency in Hz
N  = 1500; % Number of samples
t = 0:N-1; % Time domain indices

% Freqs > 420 Hz must be suppressed with TRANSITION BW = 20 Hz (410-430 Hz)
% linear-phase with 
% - equiripple passband with max ripple = 0.01
% - equiripple stopband with max ripple = 0.1
% Fp = 410, wp = 2*pi*Fp*FT
% Fs = 430, ws = 2*pi*Fs*FT
% Ap = -20log10(1 - 0.01) = 0.0873
% As = -20log10(0.1)      = 20

% Freqs < 50 Hz must be suppressed with 
% - STOPBAND ATTENUATION As = 50 dB,
% - max passband ripple  Ap = 2 dB
% - stopband edge freq   Fs = 40 Hz
% - passband edge freq   Fp= 60 Hz

% a) we got frequency components for analog signal x_c(t):
% 20,40,75,100,200,300,350,440,460,475 Hz
% Create discrete-time x[n] by sampling x_c(t) @ 1 kHz
x = zeros(1,N); % x[n]
% Declare list of analog frequencies for x_c(t)
freqs = {20, 40, 75, 100, 200, 300, 350, 440, 460, 475};
% Calculate x[n] based on sampling frequency
for idx = 1:length(freqs)
    f = freqs{idx};
    x = x + sin(2*pi*f/FT*t); 
end
% Display x[n] and frequency spectrum
figure(1);
% Plot x[n]
subplot(311); plot(t,x);
title('x[n]');
xlabel('Time');
ylabel('Amplitude');

Fx = fft(x);
% Plot magnitude of fft of x[n]
subplot(312); plot(t,abs(Fx));
title('|X(e^j^*^w)|');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Plot phase of fft of x[n]
subplot(313); plot(t,angle(Fx));
title('<X(e^j^*^w)');
xlabel('Frequency (Hz)');
ylabel('Phase');

% b) Design digital filters to meet design considerations
% Lowpass filter design
Fpass_low = 410;
Fstop_low = 430;
Dpass_low = 0.01;
Dstop_low = 0.1;
Apass_low = -20*log10(1-Dpass_low);
Astop_low = -20*log10(Dstop_low);

% Create lowpass filter
d1 = fdesign.lowpass('Fp,Fst,Ap,Ast',Fpass_low,Fstop_low,Apass_low,Astop_low,FT);
% Design equiripple lowpass filter
Hd1 = design(d1,'equiripple');
% Use fvtool to get amplitude, log-magnitude, and impulse filter responses
% fvtool(Hd1);

% Highpass filter design
Fpass_high = 60;
Fstop_high = 40;
Apass_high = 2;
Astop_high = 50;
% Create highpass filter
d2 = fdesign.highpass('Fst,Fp,Ast,Ap',Fstop_high,Fpass_high,Astop_high,Apass_high,FT);
% Design equiripple highpass filter
Hd2 = design(d2,'equiripple');
% Use fvtool to get amplitude, log-magnitude, and impulse filter responses
% fvtool(Hd2);

% Cascade both filters
Hd = dfilt.cascade(Hd1,Hd2);
% Use fvtool to get amplitude, log-magnitude, and impulse filter responses
% fvtool(Hd);

% c) Process x[n] through 'combined filter' to obtain y[n]
y = filter(Hd,x);

figure(2);
% Plot input sequence
subplot(211); plot(t,x);
title('x[n]');
xlabel('Time');
ylabel('Amplitude');
% Plot output sequence
subplot(212); plot(t,y);
title('y[n]');
xlabel('Time');
ylabel('Amplitude');

% Plot spectra of input and filtered signals
% input signal
figure(3);
% Plot magnitude of input signal
subplot(211); plot(t,abs(Fx))
title('|X(e^j^*^w)|');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
% Plot phase of input signal
subplot(212); plot(t,angle(Fx))
title('<X(e^j^*^w)');
xlabel('Frequency (Hz)');
ylabel('Phase');

% filtered signal
Fy = fft(y);
figure(4);
% Plot magnitude of filtered signal
subplot(211); plot(t,abs(Fy))
title('|Y(e^j^*^w)|');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
% Plot phase of filtered signal
subplot(212); plot(t,angle(Fy))
title('<Y(e^j^*^w)');
xlabel('Frequency (Hz)');
ylabel('Phase');

% Plot spectral density for further analysis
figure(5);
subplot(211); periodogram(x,[],length(x),1000);
title('Periodogram Power Spectral Density Estimate x[n]');
subplot(212); periodogram(y,[],length(x),1000);
title('Periodogram Power Spectral Density Estimate y[n]');

