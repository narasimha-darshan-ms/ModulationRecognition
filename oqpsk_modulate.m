function [xn_noise_if, sigpow] = oqpsk_modulate(n, fs, sps, fif, dsss, sd)
	
	%symbol to chip mapping for oqpsk
	%symbol for oqpsk is made from 4 bits, so there are 2^4
	%combinations. Each symbol is spread to 16 chips.
	pn(:,1) = [0 0 1 1 1 1 1 0 0 0 1 0 0 1 0 1]';
	pn(:,2) = [0 1 0 0 1 1 1 1 1 0 0 0 1 0 0 1]';
	pn(:,3) = [0 1 0 1 0 0 1 1 1 1 1 0 0 0 1 0]';
	pn(:,4) = [1 0 0 1 0 1 0 0 1 1 1 1 1 0 0 0]';
	pn(:,5) = [0 0 1 0 0 1 0 1 0 0 1 1 1 1 1 0]';
	pn(:,6) = [1 0 0 0 1 0 0 1 0 1 0 0 1 1 1 1]';
	pn(:,7) = [1 1 1 0 0 0 1 0 0 1 0 1 0 0 1 1]';
	pn(:,8) = [1 1 1 1 1 0 0 0 1 0 0 1 0 1 0 0]';
	pn(:,9) = [0 1 1 0 1 0 1 1 0 1 1 1 0 0 0 0]';
	pn(:,10) = [0 0 0 1 1 0 1 0 1 1 0 1 1 1 0 0]';
	pn(:,11) = [0 0 0 0 0 1 1 0 1 0 1 1 0 1 1 1]';
	pn(:,12) = [1 1 0 0 0 0 0 1 1 0 1 0 1 1 0 1]';
	pn(:,13) = [0 1 1 1 0 0 0 0 0 1 1 0 1 0 1 1]';
	pn(:,14) = [1 1 0 1 1 1 0 0 0 0 0 1 1 0 1 0]';
	pn(:,15) = [1 0 1 1 0 1 1 1 0 0 0 0 0 1 1 0]';
	pn(:,16) = [1 0 1 0 1 1 0 1 1 1 0 0 0 0 0 1]';

	%generate symbols for oqpsk
	data = randi([0 15], n, 1);
	%spreading by mapping symbols to chips
	data_dsss = arrayfun(@(x) pn(:,x+1), data, ...
'UniformOutput', false);
	
	%new input sequence for oqpsk modulation
	data_dsss = cell2mat(data_dsss);
	
	%create modulator system object
	hMod = comm.MSKModulator('SamplesPerSymbol', sps, ...
'BitInput', true);
	%modulate oqpsk signal
	xn = step(hMod, data_dsss);
	
	%build time sequence
	t = 0:1/fs:(length(xn)/fs-1/fs);
	%transpose time sequence to obtain column vector
	t = t';
	
	%mix to low intermediate frequency
	xn = real(xn.*exp(i*2*pi*fif*t));
	%generate noise sequence
	nn = sd*randn(length(xn),1);
	
	%add noise to received signal
	xn_noise_if = xn + nn;
	%calculate signal power for this sample
	sigpow = mean((xn).^2);
	
end