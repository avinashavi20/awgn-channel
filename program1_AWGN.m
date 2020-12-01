close all;  %clear all figure windows
clear all;  %clear all variables from memory

SNRdB = [2:1:11];  %dB SNR
SNR = 10.^(SNRdB/10);
blockLength = 100000;    %Number of symbols/bits per block


bits = randi([0,1],[1,blockLength]);    %Generating the bits
ModSym = 2*bits - 1;  %Generating BPSK symbols
n = randn(1, blockLength) + 1i*randn(1, blockLength);   %ZMCSCG Noise

for kx = 1:length(SNR)
    x = sqrt(SNR(kx)) * ModSym;   %Transmitted Symbols
    y = x + n;  %AWGN channel model
    
    DecodedBits = (real(y) >= 0); 
    BER(kx) = (sum(DecodedBits ~= bits))/blockLength;
    
end

semilogy(SNRdB, BER, 'b - s')
grid on;
hold on;
semilogy(SNRdB, qfunc(sqrt(SNR)), 'r -. o')

axis tight;

xlabel('SNRdb');
ylabel('BER');
title('BER vs SNR for AWGN channel')
