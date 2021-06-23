fig = figure('Menu', 'none', 'ToolBar', 'none');

% set sampling frequency and period
Fs = 8000;
Ts = 1.0 / Fs;
% set tone frequency for a middle A
F0 = 440;
% set a tone duration in seconds lol
TONE_DURATION_SECS = 2;

NUM_SAMPS = int32(TONE_DURATION_SECS * Fs);
t = double(0:(NUM_SAMPS-1)) * Ts; % sampling times
t_dense = double(0:10*NUM_SAMPS-1) * Ts/10; % dense sampling times

NUM_TO_PLOT = int32(2*Fs/F0);

%%%
%%% Harmonic Series for Square Wave
%%%
for NUM_HARMONICS = 1:4:13
    y       = sin(2*pi*F0*t);       % fundamental
    y_dense = sin(2*pi*F0*t_dense); % densely sampled
    
    for i = 3:2:NUM_HARMONICS
        y = y + sin(2*pi*i*F0*t)/i;
        y_dense = y_dense + sin(2*pi*i*F0*t_dense)/i;
    end
    
    plot(t_dense(1:NUM_TO_PLOT*10), y_dense(1:NUM_TO_PLOT*10))
    hold on
    stem(t(1:NUM_TO_PLOT), y(1:NUM_TO_PLOT));
    hold off
    
    if (F0 * NUM_HARMONICS >= Fs/2)
	Nyq_str = '(BEYOND NYQUIST)';
    else 
        nyq_str = '';
    end
    title_str=sprintf ('Highest harmonic is %d Hz %a, Fs= %d Hz\n' , F0*NUM_HARMONICS, nyq_str, Fs);

    xlim ([t(1) t(NUM_TO_PLOT)]);
    ylim ([-2 2]);
    title (title_str)
    xlabel ('Time (sec)');

    sound(y,Fs)
    pause(TONE_DURATION_SECS)
    pause

    % create a vector representing sampling times for the specified duration

    % create a vector with single sampled sine wave, at tone freq, plot and
    % play vector as a sound

    % Add 3rd and 5th harmonics, plot and listen

    % 7th and 9th harmonics, plot and listen

    % 11th and 13th harmonics, plot and listen

    % use "hold on" to freeze plot of sampled array

    % recompute same waveform using sampling freq of 80kHz
    % overlay densely sampled signal on the same plot (same times on x-axis)
end

%%%
%%% Sine wave of 1 KHz, vary sampling frequency down, to below Nyquist
%%%

F0=1000;
Fs=48000;
y=sin(2*pi*F0*(0:(TONE_DURATION_SECS*Fs-1)) / Fs);

NUM_SAMPS=length(y);

Plot_indices = 1:500;

for div = 1:5:31
	sub_indices=0:div:(NUM_SAMPS-1);
	plot_sub_indices=plot_indices(1:div:end);

	signal_prime=y(sub_indices+1);
	plot(plot_indices-1, y(plot_indices))
	hold on
	stem(plot_sub_indices-1, y(plot_sub_indices));
	hold off
	drawnow
    
    fs_prime =  Fs/div;
    if (F0 >= fs_prime/2)
        nyq_str= "(BEYOND NYQUIST)";
    else 
        nyq_str='';
    end
    title_str = sprintf('Tone frequency is %d Hz %s, sampling rate is %d Hz\n', F0, nyq_str, round(fs_prime) );

    xlim ( [(plot_indices (1)-1) (plot_indices(end)-1) ] );
    ylim([-2 2]);
    title(title_str)
    xlabel ('Sample Index');

    sound (signal_prime, fs_prime)
    pause (TONE_DURATION_SECS)
    pause
end

%%%
%%% Sampling Rate of 8KHz, Increase Frequency of Sine Wave
%%%

Fs=8000;
Ts=1.0/Fs; %sampling period

NUM_SAMPS =int32(TONE_DURATION_SECS *Fs);
t= double(0:(NUM_SAMPS-1)) * Ts;
T_dense = double (0:10*NUM_SAMPS-1) * Ts/10;
NUM_TO_PLOT=100;

for i=1:8
	FO= i*995;
	y= sin(2*pi*FO*t);
	y_dense= sin(2*pi*FO*t_dense);

	plot (t_dense (1:NUM_TO_PLOT *10), y_dense(1:NUM_TO_PLOT*10))
	hold on
	stem (t(1:NUM_TO_PLOT*10), y(1:NUM_TO_PLOT));
	hold off

	fs_prime = Fs;
	if (FO >= fs_prime/2)
		nyq_str = '(BEYOND NYQUIST)';
	else 
		nyq_str = '';
	end
	title_str=sprintf ('Tone frequency is %d Hz %s, sampling rate is %d Hz \n', FO, nyq_str, Fs);
	xlim ([t(1) t(UNM_TO_PLOT)]);
	ylim ([-2 2]);
	title ( title_str )
	xlabel ('time (sec)');

	drawnow 
	sound(y,Fs)
	pause(TONE_DURATION_SECS)
	pause
end

%%%
%%% Good news, everyone! Listen to aliasing
%%%

[y, Fs] =audioread ('good_news.wav');

y= y(:,1)';         % just keep left channel
                    % transpose to row vector
y=y/max(y);         % normalize to max value of 1.0

%NUM_SAMPS=length(y);
NUM_SAMPS=48000;

TONE_DURATION_SECS_2 = NUM_SAMPS/Fs;

plot_indices=29000:30499;

for div = 1:5:21
	Fs_prime = Fs/div;
	sub_indices = 0:div:(NUM_SAMPS-1);
    plot_sub_indices = plot_indices(1:div:end);
    signal_prime= y(sub_indices+1);

    plot(plot_indices, y(plot_indices))
    hold on
    stem (plot_sub_indices, y( plot_sub_indices));
    hold off

    title_str= sprintf ('Sampling rate is %d Hz, source provided at %d Hz\n', round(fs_prime, Fs);
    title( title_str)
    xlim ([plot_indices(1) plot_indices(end)]);
    ylim ([ -2 2]);
    xlabel ('Sample Index');
    drawnow 

    sound( signal_prime, fs_prime)
    pause (TONE_DURATION_SECS_2)
    pause
end 

%%%
%%% Good news, everyone! Limit to 3.3 KHz
%%%

[yf, Fs] = audioread('good_news.wav');
yf= yf(:,1)';

%just keep left channel
%transpose to row vector

%get lowpass filter coeffs in num 
load('filt_3300_48000_coeffs.mat');
%lowpass filter to 1 khz cutoff
yf=conv(yf, Num, 'same');
%normalize to max value of 1.0
yf=yf/max(yf);
%NUM_SAMPS=length(yf);
NUM_SAMPS=48000;

TONE_DURATION_SECS_2= NUM_SAMPS/Fs;

plot_indices= 29000:30499;
sub_indices= 0:div:(NUM_SAMPS-1);
plot_sub_indices = plot_indices(1:div:end);
signal_prime= y(sub_indices+1);

plot(plot_indices, y(plot_indices))
hold on
plot(plot_indices, yf(plot_indices))
stem (plot_sub_indices, yf(plot_sub_indices));
hold off

title_str = sprintf('Lowpass filtered to 1 khz, sampling rate is %d hz, source provided at %d Hz\n', round(fs_prime), Fs);
title(title_str)
xlabel('sample index');
xlim([plot_indices(1) plot_indices(end)]);
ylim([-2 2]);
drawnow

sound(signal_prime, fs_prime)
pause(TONE_DURATION_SECS_2)
pause

%%%
%%% Discrete convolution, using vector inner product
%%%

[y, Fs] = audioread('good_news.wav');
y= y(:,1)';
%just keep lef channel
%transpose to row vector

impulse_resp=Num;

impulse_resp_len = length(impulse_resp);
num_padding = impulse_resp_len-1;
lft_padding = floor(num_padding/2);
rgt_padding = num_padding - lft_padding;

y_pad= [zeros(1, lft_padding), y, zeros(1, rgt_padding) ];

NUM_SAMPS=length(y);
yf1=zeros (1, NUM_SAMPS);

for i=1:NUM_SAMPS
yf1(i)= flip(impulse_resp)*y_pad(i:1+num_padding)’;
end

yf1 = yf1/max(yf1);
fprintf('Max difference, yf1 vs. conv() function: %g\n', max(abs(uf-yf1)));

%%%
%%% Discrete convolution, using only basic operators
%%%

[y, Fs] = audioread('good_news.wav');
y = y(:,1)';            % just keep left channel
                        % transpose to row vector
impulse_resp = Num;

impulse_resp_len 	= length(impulse_resp);
num_padding 		= impulse_resp_len - 1;
lft_padding		= floor(num_padding/2);
rgt_padding		= num_padding - lft_padding;

y_pad = [ zeros(1, lft_padding), y, zeros(1, rgt_padding) ];

NUM_SAMPS = length(y);
yf2 = zeros(1, NUM_SAMPS);

for i = 1:NUM_SAMPS
	sum = 0;
	for j = 0:num_padding
		sum = sum + impulse_resp(impulse_resp_len - j) * y_pad(i+j);
	end
	yf2(i) = sum;
end

yf2 = yf2 / max(yf2);

fprintf('Max difference, yf2 vs. conv() function: %g\n', max(abs(yf-yf2)));

