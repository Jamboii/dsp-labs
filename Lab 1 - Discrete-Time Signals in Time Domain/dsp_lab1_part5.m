fig = figure('Menu', 'none', 'ToolBar', 'none'); % remove menu and toolbar

% Perform digital lowpass filtering (brick-wall 3.3 kHz filter)

[y, Fs] = audioread('good_news.wav');

y = y(:,1)';    % just keep left channel
                % transpose to row vector
y = y / max(y); % normalize to max value of 1.0

load('filt_3300_48000_coeffs.mat'); % Get lowpass filt coefficients in Num
yf = conv(y, Num, 'same');          % Lowpass filter to 1 kHz cutoff
yf = yf / max(y);                   % Normalize to max value of 1.0

SAMPLE_NUM = length(yf);
% SAMPLE_NUM = 48000;

SIGNAL_DURATION = SAMPLE_NUM / Fs;

% Select indices to plot filter over
div = 21;
plot_indices        = 40000:41000;

fs_prime            = Fs / div;
sub_indices         = 0:div:(SAMPLE_NUM-1);
plot_sub_indices    = plot_indices(1:div:end);
signal_prime        = y(sub_indices+1);

% Graph normal plot
plot(plot_indices, y(plot_indices))
hold on
% Plot convolution from conv method
plot(plot_indices, yf(plot_indices))
stem(plot_sub_indices, yf(plot_sub_indices));
hold off

% Edit plot title and axes
title_str=sprintf('Lowpass filtered to 1 kHz, sampling rate is %d hz, source provided at %d Hz\n', round(fs_prime), Fs);
title(title_str)

xlabel('sample index');
xlim([plot_indices(1) plot_indices(end)]);
ylim([-2 2]);
% drawnow

% Play vector as a sound under sampling frequency
sound(signal_prime, fs_prime)
pause(SIGNAL_DURATION)
% Pause sound clip and wait for key press for next sound
pause

%%%%
% Convolution the hard way
%%%%

% Pad inputs
impulse_resp = Num;

impulse_resp_len = length(impulse_resp);
num_padding      = impulse_resp_len-1;
lft_padding      = floor(num_padding/2);
rgt_padding      = num_padding - lft_padding;

y_pad = [zeros(1, lft_padding), y, zeros(1, rgt_padding)]; % pad with 0's
                                                           % left & right
                                                           
% old-school compute convolution
SAMPLE_NUM = length(y);
yf1 = zeros(1, SAMPLE_NUM);

for n = 1:SAMPLE_NUM
    % compute conv value
	conv_value = 0;
	for k = 0:num_padding
		conv_value = conv_value + impulse_resp(impulse_resp_len-k) * y_pad(n+k);
	end
	yf1(n) = conv_value;
end
yf1 = yf1 / max(yf1);   % normalize to max value of 1.0

% compare easy way vs old-school convolution computation
fprintf('Max difference, yf2 vs. conv() function: %g\n', max(abs(yf-yf1)));

