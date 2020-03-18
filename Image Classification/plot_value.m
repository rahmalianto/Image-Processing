close all;
clear all;
clc;

load('data_entropy.mat');
load('data_luas.mat');

data_luas = transpose(luas);
data_entropy = transpose(entropy);
figure,
plot(entropy);
figure,
plot(luas);
save('data_luas','data_entropy','-MAT');
save('data_entropy','data_luas','-MAT');