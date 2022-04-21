f = 1e3; %信号频率
fs = 20*f; %采样频率
N = 3; %滤波器阶数
t = 0:1/fs:1;
trainLength = 800;
SNR = 10;
mu = 0.08;

x_train = cos(2*pi*f*t(1:trainLength));
x_real = cos(2*pi*f*t(trainLength+1:end));
x = awgn([x_train x_real], SNR, 'measured');
w = zeros(N, trainLength);
e = zeros(1, length(t));
de = zeros(1, length(t));

for n = 1:trainLength-(N-1)
    de(n) = w(1, n)*x(n) + w(2, n)*x(n+1) + w(3, n)*x(n+2);
    e(n) = x_train(n) - de(n);

    w(1, n+1) = w(1, n) + mu*x(n)*e(n);
    w(2, n+1) = w(2, n) + mu*x(n+1)*e(n);
    w(3, n+1) = w(3, n) + mu*x(n+2)*e(n);
end

figure(1);
plot(w');
title('权向量');
