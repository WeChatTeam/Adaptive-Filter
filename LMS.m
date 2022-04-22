clc
clear all
close all


f = 1e3; %�ź�Ƶ��
fnoise = 3e3; %����Ƶ��
fs = 20*f; %����Ƶ��
N = 5; %�˲�������
t = 0:1/fs:1;
trainLength = 500; %ѵ�����г���
mu = 0.3; %����

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
title('Ȩ����');
figure(2);
subplot(3,1,1);
plot(t(1:trainLength), de(1:trainLength));
title('�˲����');
subplot(3,1,2);
plot(t(1:trainLength), x(1:trainLength));
title('���Ӻ�ĸ����ź�');
subplot(3,1,3);
plot(t(1:trainLength), x_train(1:trainLength));
title('ԭ�ź�');
