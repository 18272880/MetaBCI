clear all;
clc;
eeglab

     EEG.etc.eeglabvers = '2021.0'; % this tracks which version of EEGLAB is being used, you may ignore it
%      EEG = pop_loadbv('F:\data0408\', '04.vhdr', [1 435650], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%      EEG = pop_loadbv('F:\0414\', '01.vhdr', [1 610400], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%      EEG = pop_loadbv('F:\data\0425\', '04.vhdr', [1 518450], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%      EEG = pop_loadbv('F:\data\0423\', '01.vhdr', [1 599750], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%      EEG = pop_loadbv('F:\data\0422\', '03.vhdr', [1 478650], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%    EEG = pop_biosig('C:\Users\�����\Desktop\yanglongdsi\xjt01_0001_raw.edf');
     
%      EEG = pop_loadbv('F:\data\0426\', '01.vhdr', [1 503300], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
%      EEG = pop_loadbv('F:\data\0425\', '05.vhdr', [1 477250], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
     % ��EEGLAB
% Written By Yizhou
% Using the code without proper understanding the code and relevant background
% of EEG may lead to confusion, incorrect data analyses, or misinterpretations
% of results.
% The author assumes NO responsibility for inappropriate or incorrect use
% of this code.
% WX��         17373158786



% ����ȱʧmarker������
EEG = pop_biosig('C:\Users\�����\Desktop\yanglongdsi\xjt01_0001_raw.edf');

% ����marker����
frequencies = [10 11 10 11 10 11 10 11 12 13 12 13 12 13 12 13 14 16 14 16 14 16 14 16 10 11 10 11 10 11 10 11 12 13 12 13 12 13 12 13 14 16 14 16 14 16 14 16];
start_time = 1000; % ��ʼʱ��Ϊ1�� (��λ������)
duration = 4000; % ÿ���̼�����ʱ��Ϊ4�� (��λ������)

% ����ÿ���¼�����ʼʱ�� (��λ������)
latencies = start_time:duration:(start_time + duration * (length(frequencies) - 1));

% �����¼����ͺͳ���ʱ������
event_types = frequencies; % ʹ��Ƶ����Ϊ�¼�����
event_durations = repmat(duration, 1, length(frequencies)); % ����ʱ��Ϊ4��

% �����¼��������
events = struct('type', num2cell(event_types), 'latency', num2cell(latencies), 'duration', num2cell(event_durations));

% ����¼���EEG�ṹ
EEG.event = events;

% �������marker�������
EEG = pop_saveset(EEG, 'filename', 'xjt01_with_events.set', 'filepath', 'C:\Users\�����\Desktop\yanglongdsi\');

eeglab redraw;


     EEG = eeg_checkset( EEG );
     event_types = [1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 28 29 3 30 31 32 33 34 35 36 37 38 39 4 40 41 42 43 44 45 46 47 48 5 6 7 8];

     EEG = pop_epoch(EEG, num2cell(event_types), [0 8], 'newname', 'EDF file epochs', 'epochinfo', 'yes');     EEG = eeg_checkset( EEG );
     EEG = pop_rmbase( EEG, [],[]);
     EEG = eeg_checkset( EEG );
     EEG = pop_select( EEG, 'channel',[1 7 10 13 14 15 16 22 23 24]);
     EEG = eeg_checkset( EEG );
     EEG = pop_reref( EEG, [3 8] );
     EEG = eeg_checkset( EEG );
     
     traindata=EEG.data(:,251:1250,:);
     [traindata] = FilterData(traindata, 1000, 'locutoff',5);
     [traindata] = FilterData(traindata, 1000, 'hicutoff',30);
     save('data005zhang','traindata');

load ('Freq_Phase0328.mat');    %Ƶ�ʡ���λ��Ϣ
%traindata_truncated = traindata(1:263808);
eeg = reshape(traindata, 10, [], 6, 8);   %��������TRCA�㷨����ά����
eeg = double(eeg);   %�������ľ����Ϊ˫����

[N_channel,~, N_target, N_block] = size(eeg);    %��ȡ�缫������Ϣ��Ŀ��������Ϣ��block������Ϣ
tic   %��ʼ��ʱ

% load("mark012.mat");
load("mark010.mat");
tempEEG = eeg;

for loocv_i = 1:N_block   %loocv��1ȡ��6
    for targ_i = 1:N_target
        eeg(:,:,targ_i,loocv_i) = tempEEG(:,:,order(targ_i,loocv_i),loocv_i);
    end
end
% LOO cross-validation     ������֤
output = [];
for loocv_i = 1:N_block
     Testdata = squeeze(eeg(:, :, :, loocv_i));
     Traindata = eeg;
     Traindata(:, :, :, loocv_i) = [];
    for targ_i = 1:N_target
        aver_Traindata(:, :, targ_i) = squeeze(mean(squeeze(Traindata(:,:,targ_i,:)),3));
    end % end targ_i
    
    % labels assignment according to testdata
    truelabels=freqs;
    
    N_testTrial=size(Testdata, 3);
    for trial_i=1:N_testTrial
        coefficience = zeros(1,length(truelabels));
        for targ_j=1:length(freqs)             
            % compute spatial filter wn using training data
            wn = TRCA(squeeze(Traindata(:,:,targ_j,:)));
            % compute correlation between test and averaged training data
            weighted_train = wn'*aver_Traindata(:,:,targ_j);
            weighted_test = wn'*Testdata(:,:,trial_i);
            coefficienceMatrix = corrcoef(weighted_test,weighted_train);
            coefficience(targ_j) = coefficienceMatrix(1,2);
        end % end targ_i

            % target detection
            [~, index] = max(coefficience);
            outputlabels(trial_i) = freqs(index);
            
    end % end trial_i
    trueNum = sum((outputlabels-truelabels)==0);
    acc(loocv_i) = trueNum/length(truelabels);
    output = [output,outputlabels];
    fprintf('The %d-th CV accuracy is: %.4f, samples: %d/%d\n',loocv_i,...
        acc(loocv_i),trueNum, N_testTrial)
end % end looCv_i
t=toc;
% data visualization
fprintf('\n-----------------------------------------\n')
disp(['total time: ',num2str(t),' s']);
fprintf('6-fold CV average accuracy is: %.4f\n',mean(acc))