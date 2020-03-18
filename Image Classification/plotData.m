function plotData

clc

load('koin.mat', 'A');

%koin 100
rata1 = mean(A(1:11,:));
std1 = std(A(1:11,:),1);
figure, subplot(1,3,1),
hold on
plot(A(1:11,1),A(1:11,2),'*k')
plot(A(12:22,1),A(12:22,2),'*r')
plot(A(23:33,1),A(23:33,2),'*')
hold off

%koin 200
rata2 = mean(A(12:22,:));
std2 = std(A(12:22,:),1);
subplot(1,3,2),
hold on
plot(A(1:11,1),A(1:11,3),'*k')
plot(A(12:22,1),A(12:22,3),'*r')
plot(A(23:33,1),A(23:33,3),'*')
hold off

%koin 500
rata5 = mean(A(23:33,:));
std5 = std(A(23:33,:),1);
subplot(1,3,3),
hold on
plot(A(1:11,2),A(1:11,3),'*k')
plot(A(12:22,2),A(12:22,3),'*r')
plot(A(23:33,2),A(23:33,3),'*')
hold off

for i = 1:33
    jarak(i,1) = sqrt(sum(((A(i,:) - rata1)/std1)^2));
    jarak(i,2) = sqrt(sum(((A(i,:) - rata2)/std2)^2));
    jarak(i,3) = sqrt(sum(((A(i,:) - rata5)/std5)^2));
end

jarak


end