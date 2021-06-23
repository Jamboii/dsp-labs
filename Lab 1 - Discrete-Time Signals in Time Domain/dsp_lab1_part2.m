fig = figure('Menu', 'none', 'ToolBar', 'none'); % remove menu and toolbar

SIGNAL_DURATION = 2;    % signal duration
Fs = 48000;             % sampling frequency
Fs_div = Fs / 6;      % every 6th sample
Ts = 1 / Fs;            % sampling period
Ts_prime = 1 / Fs_div; % period every 6th sample
F0 = 1000;              % tone frequency

% Create a single sampled sine wave
% Subsample it via decimation at different factors

% Create vector representing sampling times for the specified duration
SAMPLE_NUM = int32(SIGNAL_DURATION * Fs);
SAMPLE_NUM_prime = int32(SIGNAL_DURATION * Fs_div);
t       = double(0:(SAMPLE_NUM-1)) * Ts;                % sample at specified Fs
t_prime = double(0:(SAMPLE_NUM_prime-1)) * Ts_prime;    % sample at specified Fs/6

% Create vector W of a single sampled sine wave at the tone frequency
W = sin(2*pi*F0*t);

POINTS_NUM = length(W);
plot_indices = 1:500;

% Create a vector for every div amount of samples
for div = 1:5:31
    % Select indices for every div samples
	sub_indices = 0:div:(POINTS_NUM-1);
	plot_sub_indices = plot_indices(1:div:end);

	W_prime = W(sub_indices + 1);
    
    % Plot waveform at specified indices
	plot(plot_indices-1, W(plot_indices))
	hold on
    % Plot compressed waveform at subsampled indices
	stem(plot_sub_indices-1, W(plot_sub_indices));
	hold off
    
    nyq_str = '';
    % Adjust sampling frequency according to specified div
    Fs_div =  Fs / div;
    if (F0 >= Fs_div/2)
        nyq_str = strcat(nyq_str, '(BEYOND NYQUIST)'); % don't capture all ripples, hear a second tone
    else 
        nyq_str = strcat(nyq_str, '(SATISFIES NYQUIST)');
    end
    
    % Edit plot title and axes
    title_str = sprintf('Tone frequency is %d Hz, Fs= %i Hz %s\n', F0, round(Fs_div), nyq_str);
    disp(title_str) 

    xlim([(plot_indices (1)-1) (plot_indices(end)-1)]);
    ylim([-3 3]);
    
    title(title_str)
    xlabel('Index');

    % Play vector as a sound under sampling frequency
    sound(W_prime, Fs_div)
    pause(SIGNAL_DURATION)
    
    % Pause sound clip and wait for key press for next sound
    pause
end

% tone freq different sampling rates
% until we go under nyquist and hear another note
