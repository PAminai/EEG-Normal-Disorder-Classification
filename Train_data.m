clear; close all; clc;

% Addressing 
path_data='D:\EEG\Final_report\Prep_Data\';
data_norm='_norm.mat';
data_dis='_dis.mat';

% Data Preparation
norm=[];
dis=[];

%Brain Freqs
u=[61 64];
l=[57 60];

% Load training data

for i=1:132 % 132 of 132 normal
    subj=num2str(i);
    name_norm=strcat(subj,data_norm);
    address_norm=strcat(path_data,name_norm);
    load(address_norm)
    norm=[norm; bandpower(final_eeg,512,u)./bandpower(final_eeg,512,l)];
    i
end


for i=1:196 % 196 of 196 disorder ( because of rectangular matrix)
    subj=num2str(i);
    name_dis=strcat(subj,data_dis);
    address_dis=strcat(path_data,name_dis);
    load(address_dis);
    dis=[dis;  bandpower(final_eeg,512,u)./bandpower(final_eeg,512,l)];
    i
end

dis=dis';
norm=norm';

T_norm=[zeros(1,132)];
T_dis=[ones(1,196)];


x=[norm dis]; 

t=[T_norm, T_dis]; %labels

Train=[x;t];
