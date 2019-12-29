close all; clear; clc;

%loading classifier
load('D:\EEG\Final_report\Predict\classifiers\katz_subknn_100.mat');


%addressing data
data_subj='_test.mat';
path_data='D:\EEG\Final_report\Predict\Prepared_Data\';
labels=[];

%Brain Freqs
%u=[61 64];
%l=[57 60];


for i=1:72
    i
    subj=num2str(i);
    name_subj=strcat(subj,data_subj);
    address_dis=strcat(path_data,name_subj);
    load(address_dis);
    
    katz=[];

    for k=1:19
       katz= [katz, Katz_FD(final_eeg(:,k),1)];
    end
    
    features=[katz];
    
    labels=[labels; predict(katz_subknn_100, features)];
end



%writing in excel file
filename = 'result.xlsx';
xlswrite(filename,labels);
find(labels==0)
