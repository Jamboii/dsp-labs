fig = figure('Menu', 'none', 'ToolBar', 'none'); % remove menu and toolbar

SIGNAL_DURATION = 2;    % signal duration
Fs = 8000;              % sampling frequency
Ts = 1.0 / Fs;          % sampling period
Ts_dense = Ts / 10;     % sampling period at 10x Fs
F0 = 995;               % tone frequency

% Create vector representing sampling times for the specified duration
SAMPLE_NUM = int32(SIGNAL_DURATION * Fs);       % number of samples to plot
t       = double(0:(SAMPLE_NUM-1)) * Ts;        % sample at specified Fs
t_dense = double(0:10*SAMPLE_NUM-1) * Ts_dense; % sample at 10*Fs

POINTS_NUM = int32(2 * Fs / F0);

% 3rd part we increase tone freq
% little warbly but theory says we can reconsturct original sine wave using
% ideal reconstruction filter
% impulse response of sinx/x
% beyond nyquist, freq again goes down up until the point where we hear
% nothing, why cant we hear this?

for i=1:8
	F0 = i * 995;
    % Create a vector with single sampled sine wave, at tone frequency
	W = sin(2*pi*F0*t);             % sample at specified Fs
	W_dense = sin(2*pi*F0*t_dense); % sample at Fs*10

    % Plot waveform at sampling frequency of 80 kHz
	plot(t_dense(1:POINTS_NUM*10), W_dense(1:POINTS_NUM*10))
    
    % Plot and play vector as a sound
	hold on
	stem(t(1:POINTS_NUM), W(1:POINTS_NUM));
	hold off

    nyq_str = '';
    % Evaluate Nyquist criterion (highest harmonic vs half sampling freq)
    if (F0 >= Fs/2)
        nyq_str = strcat(nyq_str, '(BEYOND NYQUIST)'); % don't capture all ripples, hear a second tone
    else 
        nyq_str = strcat(nyq_str, '(SATISFIES NYQUIST)');
    end 
    
    % Edit plot title and axes
    title_str = sprintf('Tone frequency is %d Hz, Fs= %i Hz %s\n', F0, Fs, nyq_str);
    disp(title_str) 
    
	xlim([t(1) t(POINTS_NUM)]);
	ylim([-2 2]);
	title(title_str)
	xlabel('time (sec)');
    
	% Play vector as a sound under sampling frequency
    sound(W,Fs)
	pause(SIGNAL_DURATION)
    
    % Pause sound clip and wait for key press for next sound
	pause
end