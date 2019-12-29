close all; clear; clc

% Address of Data
path_read='D:\EEG\Final_report\Predict\New_Shuffled_Validation(disorder_normal)\subj_';
path_save='D:\EEG\Final_report\Predict\Prepared_Data\';
name_test='_test.mat';

% Filter Design
% Bandpass
bpFilt = designfilt('bandpassfir','FilterOrder',7, ...
         'CutoffFrequency1',0.3,'CutoffFrequency2',70, ...
         'SampleRate',512);
% Notch
num=[0.9936 -1.6247 0.9936];
den=[1 -1.6247 0.9872];

% Loading Data
for i=1:72 % Number of subjects: 132_normal or 196_disorder
subj_num=i;
fprintf('Subject#%d\n',subj_num);
subj_num=num2str(subj_num);
address=strcat(path_read,subj_num);
eeg=load(address);
eeg=cell2mat(struct2cell(eeg));

eeg_ch=[];

% Channel Reduction
for j=1:19
    eeg_ch=[eeg_ch eeg(:,j)];
end

% Filtering the data
for k=1:19
eeg_ch(:,k) = filtfilt(bpFilt,eeg_ch(:,k)); % BPF
eeg_ch(:,k) = filtfilt(num,den,eeg_ch(:,k)); % notch
end
final_eeg=eeg_ch;

% Saving the data
savelink=num2str(i);
savelink=strcat(savelink,name_test);
save(savelink,'final_eeg');

end
