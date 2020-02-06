function [expTypeMouseID,timePoint] = ConvertToMouseExpID(TimeSeries,leftOrRight)
% Given TimeSeries, returns mouse IDs that combine mouse and experiment
%-------------------------------------------------------------------------------

tsKeywords = TimeSeries.Keywords;
numTS = length(tsKeywords);
keywordSplit = regexp(tsKeywords,',','split');
numKWs = cellfun(@length,keywordSplit);

isPVCre = cellfun(@(x)strcmp(x{3},'PVCre'),keywordSplit);
isWildInhib = cellfun(@(x)strcmp(x{3},'wildInhib'),keywordSplit);
isCAMK = cellfun(@(x)strcmp(x{1},'CAMK'),keywordSplit);

%isPV = cellfun(@(x)strcmp(x{4},'PV'),keywordSplit);
%isSHAM = cellfun(@(x)strcmp(x{4},'control'),keywordSplit);
%isSST = cellfun(@(x)strcmp(x{4},'SSTinh'),keywordSplit);
%isSSTcnt = cellfun(@(x)strcmp(x{4},'SSTcontrol'),keywordSplit);


%D1 data
%isD1exc = cellfun(@(x)strcmp(x{4},'excitatory'),keywordSplit);
%isD1inh = cellfun(@(x)strcmp(x{4},'inhibitory'),keywordSplit);
%isD1cnt = cellfun(@(x)strcmp(x{4},'control'),keywordSplit);


timePoint = cell(length(tsKeywords),1);
expTypeMouseID = cell(numTS,1);
for k = 1:numTS
    theName = TimeSeries.Name{k};

    % timePoint:
    % ID to identify individual mice:
%    if isPV(k) || isSHAM(k) || isSST(k) || isSSTcnt(k) || isD1exc(k) || isD1inh(k) || isD1cnt(k)
%        timePoint{k} = keywordSplit{k}{3}; % keyword is ts1/2/3
%        expTypeMouseID{k} = horzcat(keywordSplit{k}{4},keywordSplit{k}{2},theName(1:8));
%    else
    if isCAMK(k)
        timePoint{k} = keywordSplit{k}{3}; % keyword is ts1/2/3
        expTypeMouseID{k} = horzcat(keywordSplit{k}{1},keywordSplit{k}{2},theName(1:8));
    else
        if isPVCre(k) || isWildInhib(k) || strcmp(leftOrRight,'left')
            timePoint{k} = keywordSplit{k}{2};
            expTypeMouseID{k} = horzcat(keywordSplit{k}{3},keywordSplit{k}{1},theName(1:8));
        else
            timePoint{k} = keywordSplit{k}{3};
            expTypeMouseID{k} = horzcat(keywordSplit{k}{4},keywordSplit{k}{2},theName(1:8)); %4 and 2
        end
    end
end

end
