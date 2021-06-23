a = 1:5;
b = a+3;
A = fft(a);
B = fft(b);
c = a .* b;
disp(c)

D = cconv(A, B);
d = real(ifft(D));
disp(d)