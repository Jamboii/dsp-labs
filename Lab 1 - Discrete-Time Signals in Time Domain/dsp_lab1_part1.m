fig = figure('Menu', 'none', 'ToolBar', 'none'); % remove menu and toolbar

SIGNAL_DURATION = 2;    % signal duration
Fs = 8000;              % sampling frequency
Ts = 1 / Fs;            % sampling period
Ts_dense = Ts / 10;     % sampling period at 10x Fs
F0 = 440;               % tone frequency

% Create and visualize the harmonic series for a square wave
% This will be accomplished with discrete-time sampling

% Create vector representing sampling times for the specified duration
SAMPLE_NUM = int32(SIGNAL_DURATION * Fs);         % amount of samples to plot
t       = double(0:(SAMPLE_NUM-1)) * Ts;          % sample at specified Fs
t_dense = double(0:(10*SAMPLE_NUM-1)) * Ts_dense; % sample at 10*Fs

POINTS_NUM = int32(2 * Fs / F0);

for HARMONICS_NUM = 1:4:13 % 1 5 9 13
    % Create a vector with single sampled sine wave, at tone frequency
    y       = sin(2*pi*F0*t);       % fundamental frequency
    y_dense = sin(2*pi*F0*t_dense); % densely sampled 
    
    % run through different amounts of harmonics for a square wave
    % 3:2:1 ???
    % 3:2:5 3:2:9 3:2:13
    for i = 3:2:HARMONICS_NUM
        y       = y + (1/i * sin(2*pi*i*F0*t));
        y_dense = y_dense + (1/i * sin(2*pi*i*F0*t_dense));
    end
    
    % Plot waveform at sampling frequency of 80 kHz
    plot(t_dense(1:POINTS_NUM*10), y_dense(1:POINTS_NUM*10))

    % Plot and play vector as a sound
    hold on
    stem(t(1:POINTS_NUM), y(1:POINTS_NUM));
    hold off
    
    nyq_str = '';
    % Evaluate Nyquist criterion (highest harmonic vs half sampling freq)
    if (F0 * HARMONICS_NUM >= Fs/2)
        nyq_str = strcat(nyq_str, '(BEYOND NYQUIST)'); % don't capture all ripples, hear a second tone
    else 
        nyq_str = strcat(nyq_str, '(SATISFIES NYQUIST)');
    end  
    
    % Edit plot title and axes
    title_str = sprintf('Highest harmonic is %d Hz, Fs= %i Hz %s\n', F0*HARMONICS_NUM, Fs, nyq_str);
    disp(title_str) 

    xlim([t(1) t(POINTS_NUM)]);
    ylim([-1 1]);
    title(title_str)
    xlabel('Time (sec)');

    % Play vector as a sound under sampling frequency
    sound(y,Fs)
    pause(SIGNAL_DURATION)
    
    % Pause sound clip and wait for key press for next sound
    pause
end