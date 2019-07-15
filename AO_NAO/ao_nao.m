%% NAO
clear all, close all, clc
cd('C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\02_data\nao')
load('nao_ao.mat')
%%

nao.daten = datenum(nao.Year,nao.Month, ones(length(nao.Year),1))
nao.movm = movmean(nao.NAO,12)

ao.daten = datenum(ao.Year,nao.Month, ones(length(ao.Year),1))
ao.movm = movmean(ao.AO,12)
%%
close all
figure, hold on
%plot(nao.daten,nao.hNAO)
plot(nao.daten,nao.movm,'r','LineWidth',1.5)
plot(ao.daten,ao.movm,'b','LineWidth',1.5)
datetick('x','yyyy')
grid on