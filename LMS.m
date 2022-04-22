clc
clear all
close all


f = 1e3; %信号频率
fnoise = 3e3; %噪声频率
fs = 20*f; %采样频率
N = 5; %滤波器阶数
t = 0:1/fs:1;
trainLength = 500; %训练序列长度
mu = 0.3; %步长

noise = sin(2*pi*fnoise*t);
x_train = cos(2*pi*f*t(1:trainLength));
x_real = cos(2*pi*f*t(trainLength+1:end));
x = [x_train x_real] + noise;
w = zeros(N, trainLength);
e = zeros(1, length(t));
de = zeros(1, length(t));

for n = 1:trainLength-(N-1)
    de(n) = w(:,n)' * x(n:n+N-1)';
    e(n) = x_train(n) - de(n);
    w(:,n+1) = w(:, n) + mu.*x(n:n+N-1)'.*e(n);
end

figure(1);
plot(w');
title('权向量');
figure(2);
subplot(3,1,1);
plot(t(1:trainLength), de(1:trainLength));
title('滤波输出');
subplot(3,1,2);
plot(t(1:trainLength), x(1:trainLength));
title('叠加后的干扰信号');
subplot(3,1,3);
plot(t(1:trainLength), x_train(1:trainLength));
title('原信号');
