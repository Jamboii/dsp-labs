fig = figure('Menu', 'none', 'ToolBar', 'none'); % remove menu and toolbar

[y, Fs] = audioread('good_news.wav');

y = y(:,1)';    % just keep left channel
                % transpose to row vector
y = y / max(y); % normalize to max value of 1.0

SAMPLE_NUM      = length(y);        % Number of samples to graph     
% SIGNAL_DURATION = SAMPLE_NUM / Fs;  % Length of signal in seconds
SIGNAL_DURATION = 1;

PLOT_INDICES    = 40000:41000;      % Indices to plot 

for div = 1:5:21
	Fs_div              = Fs / div;                 % Divide sampling frequency by some ratio
	sub_indices         = 0:div:(SAMPLE_NUM-1);     % New amount of subplot timestamps
    plot_sub_indices    = PLOT_INDICES(1:div:end);  % Indices to plot
    signal_prime        = y(sub_indices+1);         % Grab new amount of samples
    
    % Plot waveform at specified indices
    plot(PLOT_INDICES, y(PLOT_INDICES))
    hold on
    % Plot compressed waveform at subsampled indices
    stem (plot_sub_indices, y(plot_sub_indices));
    hold off

    % Edit plot title and axes
    title_str = sprintf('Sampling rate: %d Hz\t Source: %i Hz\n', round(Fs_div), Fs);
    disp(title_str)
    
    title(title_str)
    xlim([PLOT_INDICES(1) PLOT_INDICES(end)]);
    ylim([-2 2]);
    xlabel('Sample Index');

    % Play vector as a sound under sampling frequency
    sound(signal_prime, Fs_div)
    pause(SIGNAL_DURATION)
    
    % Pause sound clip and wait for key press for next sound
    pause
end