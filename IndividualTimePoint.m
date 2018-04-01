
leftOrRight = 'control';
labelByMouse = false;
doBL = true; % use baseline subtraction
normalizeDataHow = 'scaledRobustSigmoid';

%-------------------------------------------------------------------------------
% Names of time points:
if doBL
    tsCell = {'ts2-BL','ts3-BL','ts4-BL'};
else
    tsCell = {'ts1','ts2','ts3','ts4'};
end
numTimePoints = length(tsCell);

%-------------------------------------------------------------------------------
% Load basic info on data:
[prePath,rawData,rawDataBL,normData,normDataBL] = Foreplay(leftOrRight,normalizeDataHow,labelByMouse,false);
% [prePath,rawData,rawDataBL] = GiveMeLeftRightInfo(leftOrRight);

%-------------------------------------------------------------------------------
% Filter by time point for a SINGLE brain location
%-------------------------------------------------------------------------------
doFiltering = false; % (only need to do this once)
numNulls = 50;
numRepeats = 50;
numFolds = 10;
meanAcc = zeros(numTimePoints,2);
for i = 1:numTimePoints
    theTS = tsCell{i};
    if doFiltering
        % Make new HCTSA files by filtering
        if doBL
            IDs_tsX = TS_getIDs(theTS(1:3),rawDataBL,'ts');
        else
            IDs_tsX = TS_getIDs(theTS,rawData,'ts');
        end
        filteredFileName = fullfile(prePath,sprintf('HCTSA_%s.mat',theTS));
        TS_FilterData(rawData,IDs_tsX,[],filteredFileName);
        normalizedData = TS_normalize(whatNormalization,[0.5,1],filteredFileName,true);
    else
        normalizedData = fullfile(prePath,sprintf('HCTSA_%s_N.mat',theTS));
    end
    fprintf(1,'\n\n TIME POINT %s \n\n\n',theTS);
    [foldLosses,nullStat] = TS_classify(normalizedData,'svm_linear','numPCs',0,...
                    'numNulls',numNulls,'numFolds',numFolds,'numRepeats',numRepeats,'seedReset','none');
    meanAcc(i,1) = mean(foldLosses);
    meanAcc(i,2) = mean(nullStat);
end

% Plot across time:
f = figure('color','w'); ax = gca; hold('on')
plot(meanAcc(:,1),'o-k');
plot(meanAcc(:,2),'x:b');
ax.XTick = 1:3;
ax.XTickLabel = tsCell;

%===============================================================================
return
return
return
return
%===============================================================================

%-------------------------------------------------------------------------------
% Across multiple hemispheres:
regionLabels = {'left','right','control'};
meanAcc = zeros(3,numTimePoints,2);
stdAcc = zeros(3,numTimePoints,2);
for k = 1:3
    [prePath,rawData,rawDataBL] = GiveMeLeftRightInfo(regionLabels{k});
    for i = 1:length(tsCell)
        theTS = tsCell{i};
        normalizedData = fullfile(prePath,sprintf('HCTSA_%s_N.mat',theTS));
        fprintf(1,'\n\n %s -- TIME POINT %s \n\n\n',regionLabels{k},theTS);
        [foldLosses,nullStat] = TS_classify(normalizedData,'svm_linear','numPCs',0,'numNulls',numNulls,...
                            'numFolds',numFolds,'numRepeats',numRepeats,'seedReset','none');
        meanAcc(k,i,1) = mean(foldLosses);
        stdAcc(k,i,1) = std(foldLosses);
        meanAcc(k,i,2) = mean(nullStat);
        stdAcc(k,i,2) = std(nullStat);
    end
end
% Plot across time:
colors = BF_getcmap('dark2',3,1,true)
f = figure('color','w'); ax = gca; hold('on')
h = cell(4,1);
for k = 1:3
    h{k} = plot(squeeze(meanAcc(k,:,1)),'o-','color',colors{k},'LineWidth',2);
    plot(squeeze(meanAcc(k,:,1))+squeeze(stdAcc(k,:,1)),'--','color',colors{k},'LineWidth',1);
    plot(squeeze(meanAcc(k,:,1))-squeeze(stdAcc(k,:,1)),'--','color',colors{k},'LineWidth',1);
end
h{4} = plot(mean(squeeze(meanAcc(:,:,2)),1),'x:k');
legend([h{:}],{'left','right','control','null'})
ax.XTick = 1:3;
ax.XTickLabel = tsCell;

%===============================================================================
return
return
return
return
%===============================================================================

%-------------------------------------------------------------------------------
% Filter by a given time point
tsCell_BL = {'ts2','ts3','ts4'};
doFiltering = false; % (only needs to be done once)
for i = 1:length(tsCell_BL)
    theTS_BL = tsCell_BL{i};
    if doFiltering
        IDs_tsX = TS_getIDs(theTS_BL,'HCTSA_baselineSub.mat','ts');
        filteredFileName = sprintf('HCTSA_baselineSub_%s.mat',theTS_BL);
        TS_FilterData('HCTSA_baselineSub.mat',IDs_tsX,[],filteredFileName);
        normalizedFileName = TS_normalize(whatNormalization,[0.5,1],filteredFileName,true);
    else
        normalizedFileName = sprintf('HCTSA_baselineSub_%s_N.mat',theTS_BL);
    end
    TS_classify(normalizedFileName,'svm_linear',false,true)
end

%-------------------------------------------------------------------------------
numFeatures = 40; % number of features to include in the pairwise correlation plot
numFeaturesDistr = 32; % number of features to show class distributions for
whatStatistic = 'fast_linear'; % fast linear classification rate statistic

TS_TopFeatures('HCTSA_baselineSub_ts2.mat',whatStatistic,'numFeatures',numFeatures,...
            'numFeaturesDistr',numFeaturesDistr,...
            'whatPlots',{'histogram','distributions','cluster'});

%-------------------------------------------------------------------------------
%% Investigate particular individual features in some more detail
annotateParams = struct('maxL',1000);
featureID = 1078; % 411
TS_FeatureSummary(featureID,unnormalizedData,true,annotateParams)