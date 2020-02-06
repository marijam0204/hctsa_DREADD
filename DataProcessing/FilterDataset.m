function FilterDataset(whatAnalysis)
% Idea is to filter all datasets based on a given analysis
% -> HCTSA_filt.mat
%-------------------------------------------------------------------------------

if nargin < 1
    whatAnalysis = 'Excitatory_SHAM';
end

leftOrRight = {'right','left','control'};
%leftOrRight = {'right','left'};
numRegions = length(leftOrRight);


for k = 1:numRegions
    [prePath,rawData] = GiveMeLeftRightInfo(leftOrRight{k});
    switch whatAnalysis
    case 'Excitatory_SHAM'
        % Already in HCTSA.mat
    case 'Wild_SHAM'
        % Need to isolate SHAM data from HCTSA.mat
        ts_keepIDs = TS_getIDs('SHAM',rawData,'ts');
        SHAMFile = fullfile(prePath,'HCTSA_SHAM.mat');
        TS_FilterData(rawData,ts_keepIDs,[],SHAMFile);
        % Now add the wildInhib data:
        %TS_combine(SHAMFile,fullfile(prePath,'HCTSA_wildInhib.mat'),false,false,fullfile(prePath,'HCTSA_wildInhib_SHAM.mat'),true);
    case 'PVCre_SHAM'
        % Need to remove Excitatory data, and add PVCre data
        SHAM_IDs = TS_getIDs('SHAM',rawData,'ts');
        [~,TS13] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
        ts_keepIDs = intersect(SHAM_IDs,TS13);
        SHAMFile = fullfile(prePath,'HCTSA_SHAM.mat');
        TS_FilterData(rawData,ts_keepIDs,[],SHAMFile);
        % Now add the PVCre data:
        TS_combine(SHAMFile,fullfile(prePath,'HCTSA_PVCre.mat'),false,false,fullfile(prePath,'HCTSA_PVCre_SHAM.mat'),true);
  case 'CAMK_SHAM'
          % Need to remove Excitatory data, and add CAMK data
          SHAM_IDs = TS_getIDs('SHAM',rawData,'ts');
          [~,TS13] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
          ts_keepIDs = intersect(SHAM_IDs,TS13);
          SHAMFile = fullfile(prePath,'HCTSA_SHAM.mat');
          TS_FilterData(rawData,ts_keepIDs,[],SHAMFile);
          % Now add the CAMK data:
          TS_combine(SHAMFile,fullfile(prePath,'HCTSA_CAMK.mat'),false,false,fullfile(prePath,'HCTSA_CAMK_SHAM.mat'),true);
  case 'CAMK_Excitatory'
            % Need to remove SHAM data, and add CAMK data
            Excitatory_IDs = TS_getIDs('excitatory',rawData,'ts');
            [~,TS13] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
            ts_keepIDs = intersect(Excitatory_IDs,TS13);
            ExcFile = fullfile(prePath,'HCTSA_Excitatory.mat');
            TS_FilterData(rawData,ts_keepIDs,[],ExcFile);
            % Now add the CAMK data:
            CAMKFile = fullfile(prePath,'HCTSA_CAMK.mat');
            TS_combine(ExcFile,CAMKFile,false,false,fullfile(prePath,'HCTSA_CAMK_Excitatory.mat'),true);
  case 'CAMK_PVCre'
           CAMKFile = fullfile(prePath,'HCTSA_CAMK.mat');
           PVCreFile = fullfile(prePath,'HCTSA_PVCre.mat');
           TS_combine(PVCreFile,CAMKFile,false,false,fullfile(prePath,'HCTSA_CAMK_PVCre.mat'),true);
  case 'CAMK_Excitatory_PVCre'
    % Exclude ts4 from excitatory data:
    Excitatory_IDs = TS_getIDs('excitatory',rawData,'ts');
    [~,TS13] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
    ts_keepIDs = intersect(Excitatory_IDs,TS13);
    ExcFile = fullfile(prePath,'HCTSA_Excitatory.mat');
    TS_FilterData(rawData,ts_keepIDs,[],ExcFile);
    % CAMK data
      CAMKFile = fullfile(prePath,'HCTSA_CAMK.mat');
    % Combine all three experimental data together:
    intermediateFile = fullfile(prePath,'HCTSA_CAMK_Exc.mat');
    TS_combine(ExcFile,CAMKFile,false,false,intermediateFile,true);
    % Now add PVCre:
    TS_combine(intermediateFile,fullfile(prePath,'HCTSA_PVCre.mat'),false,false,fullfile(prePath,'HCTSA_CAMK_Excitatory_PVCre.mat'),true);
case 'CAMK_Excitatory_PVCre_SHAM'
  % Exclude ts4 from excitatory & sham data:
  [~,ts_keepIDs] = TS_getIDs('ts4',rawData,'ts');
  T13File = fullfile(prePath,'HCTSA_T13.mat');
  TS_FilterData(rawData,ts_keepIDs,[],T13File);
  % CAMK data
  CAMKFile = fullfile(prePath,'HCTSA_CAMK.mat');
  % Combine all three experimental data together:
  intermediateFile = fullfile(prePath,'HCTSA_CAMK_Exc.mat');
  TS_combine(T13File,CAMKFile,false,false,intermediateFile,true);
  % Now add PVCre:
  TS_combine(intermediateFile,fullfile(prePath,'HCTSA_PVCre.mat'),false,false,fullfile(prePath,'HCTSA_Exc_SHAM_CAMK_PVCre.mat'),true);

  case 'PVCre_Wild'
        % Exclude ts4 from wildInhib data:
        wildInhibData = fullfile(prePath,'HCTSA_wildInhib.mat');
        [~,ts_keepIDs] = TS_getIDs('ts4',wildInhibData,'ts');
        wildInhib_ts13 = fullfile(prePath,'HCTSA_wildInhib_ts13.mat');
        TS_FilterData(wildInhibData,ts_keepIDs,[],wildInhib_ts13);
        PVCreFile = fullfile(prePath,'HCTSA_PVCre.mat');
        TS_combine(PVCreFile,wildInhib_ts13,false,false,fullfile(prePath,'HCTSA_PVCre_wildInhib.mat'),true);
    case 'Excitatory_Wild'
        % Need to remove SHAM data, and add inhibWild data
        Excitatory_IDs = TS_getIDs('excitatory',rawData,'ts');
        ExcFile = fullfile(prePath,'HCTSA_Excitatory.mat');
        TS_FilterData(rawData,Excitatory_IDs,[],ExcFile);
        % Now add the PVCre data:
        TS_combine(ExcFile,fullfile(prePath,'HCTSA_wildInhib.mat'),false,false,fullfile(prePath,'HCTSA_Exc_wildInhib.mat'),true);
    case 'Excitatory_PVCre'
        % Need to remove SHAM data, and add PVCre data
        Excitatory_IDs = TS_getIDs('excitatory',rawData,'ts');
        [~,TS13] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
        ts_keepIDs = intersect(Excitatory_IDs,TS13);
        ExcFile = fullfile(prePath,'HCTSA_Excitatory.mat');
        TS_FilterData(rawData,ts_keepIDs,[],ExcFile);
        % Now add the PVCre data:
        PVCreFile = fullfile(prePath,'HCTSA_PVCre.mat');
        TS_combine(ExcFile,PVCreFile,false,false,fullfile(prePath,'HCTSA_Exc_PVCre.mat'),true);
    case 'Excitatory_PVCre_SHAM'
        [~,ts_keepIDs] = TS_getIDs('ts4',rawData,'ts'); % exclude ts4
        T13File = fullfile(prePath,'HCTSA_T13.mat');
        TS_FilterData(rawData,ts_keepIDs,[],T13File);
        % Combine all three experimental data together:
        TS_combine(T13File,fullfile(prePath,'HCTSA_PVCre.mat'),false,false,fullfile(prePath,'HCTSA_Exc_PVCre_SHAM.mat'),true);
    case 'Excitatory_PVCre_Wild_SHAM'
        % Exclude ts4 from excitatory data:
        [~,ts_keepIDs] = TS_getIDs('ts4',rawData,'ts');
        T13File = fullfile(prePath,'HCTSA_T13.mat');
        TS_FilterData(rawData,ts_keepIDs,[],T13File);
        % Exclude ts4 from wildInhib data:
        wildInhibData = fullfile(prePath,'HCTSA_wildInhib.mat');
        [~,ts_keepIDs] = TS_getIDs('ts4',wildInhibData,'ts');
        wildInhib_ts13 = fullfile(prePath,'HCTSA_wildInhib_ts13.mat');
        TS_FilterData(wildInhibData,ts_keepIDs,[],wildInhib_ts13);
        % Combine all three experimental data together:
        intermediateFile = fullfile(prePath,'HCTSA_Exc_Wild_SHAM_t13.mat');
        TS_combine(T13File,wildInhib_ts13,false,false,intermediateFile,true);
        % Now add PVCre:
        TS_combine(intermediateFile,fullfile(prePath,'HCTSA_PVCre.mat'),false,false,fullfile(prePath,'HCTSA_Exc_PVCre_Wild_SHAM.mat'),true);
    case 'SST_SSTcnt'
    % Need to remove PVCre and SHAM, and isolate SST datasets
    ts_keepIDs = TS_getIDs('SSTinh',rawData,'ts');
    SSTFile = fullfile(prePath,'HCTSA_SST.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SSTFile);
    ts_keepIDs = TS_getIDs('SSTcontrol',rawData,'ts');
    SSTcntFile = fullfile(prePath,'HCTSA_SSTcnt.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SSTcntFile);
    % Now add combine SST and SSTcnt data:
    TS_combine(SSTFile,fullfile(prePath,'HCTSA_SSTcnt.mat'),false,false,fullfile(prePath,'HCTSA_SST_SSTcnt.mat'),true);
    case 'SST_PV'
    % Need to remove SSTcnt and SHAM, and isolate SST and PV datasets
    ts_keepIDs = TS_getIDs('SSTinh',rawData,'ts');
    SSTFile = fullfile(prePath,'HCTSA_SST.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SSTFile);
    ts_keepIDs = TS_getIDs('PVCre',rawData,'ts');
    PVFile = fullfile(prePath,'HCTSA_PV.mat');
    TS_FilterData(rawData,ts_keepIDs,[],PVFile);
    % Now add combine SST and SSTcnt data:
    TS_combine(SSTFile,fullfile(prePath,'HCTSA_PV.mat'),false,false,fullfile(prePath,'HCTSA_SST_PV.mat'),true);
    case 'SST_SHAM'
    % Need to remove PV and SSTcnt, and isolate SHAM and SST datasets
    ts_keepIDs = TS_getIDs('SSTinh',rawData,'ts');
    SSTFile = fullfile(prePath,'HCTSA_SST.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SSTFile);
    ts_keepIDs = TS_getIDs('SHAM',rawData,'ts');
    SHAMFile = fullfile(prePath,'HCTSA_SHAM.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SHAMFile);
    % Now add combine SST and SSTcnt data:
    TS_combine(SSTFile,fullfile(prePath,'HCTSA_SHAM.mat'),false,false,fullfile(prePath,'HCTSA_SST_SHAM.mat'),true);
    case 'PV_SHAM'
    % Need to remove SST and SSTcnts, and isolate PV and SHAM datasets
    ts_keepIDs = TS_getIDs('PVCre',rawData,'ts');
    PVFile = fullfile(prePath,'HCTSA_PV.mat');
    TS_FilterData(rawData,ts_keepIDs,[],PVFile);
    ts_keepIDs = TS_getIDs('SHAM',rawData,'ts');
    SHAMFile = fullfile(prePath,'HCTSA_SHAM.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SHAMFile);
    % Now add combine SST and SSTcnt data:
    TS_combine(PVFile,fullfile(prePath,'HCTSA_SHAM.mat'),false,false,fullfile(prePath,'HCTSA_PV_SHAM.mat'),true);
    case 'PV_SSTcnt'
    % Need to remove SST and SHAM, and isolate PV and SSTcnt datasets
    ts_keepIDs = TS_getIDs('PVCre',rawData,'ts');
    PVFile = fullfile(prePath,'HCTSA_PV.mat');
    TS_FilterData(rawData,ts_keepIDs,[],PVFile);
    ts_keepIDs = TS_getIDs('SSTcontrol',rawData,'ts');
    SSTcntFile = fullfile(prePath,'HCTSA_SSTcnt.mat');
    TS_FilterData(rawData,ts_keepIDs,[],SSTcntFile);
    % Now add combine SST and SSTcnt data:
    TS_combine(PVFile,fullfile(prePath,'HCTSA_SSTcnt.mat'),false,false,fullfile(prePath,'HCTSA_PV_SSTcnt.mat'),true);
    case 'SST_SSTcnt_PV_SHAM'
    % already in HCTSA.mat


    case 'D1exc_D1inh'
    % Isolate D1 excitatory and inhibitory
    ts_keepIDs = TS_getIDs('excitatory',rawData,'ts');
    D1excFile = fullfile(prePath,'HCTSA_D1exc.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1excFile);
    ts_keepIDs = TS_getIDs('inhibitory',rawData,'ts');
    D1inhFile = fullfile(prePath,'HCTSA_D1inh.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1inhFile);
    % Now combine them
    TS_combine(D1excFile,fullfile(prePath,'HCTSA_D1inh.mat'),false,false,fullfile(prePath,'HCTSA_D1exc_D1inh.mat'),true);
    case 'D1exc_D1cnt'
    % Isolate D1 excitatory and inhibitory
    ts_keepIDs = TS_getIDs('excitatory',rawData,'ts');
    D1excFile = fullfile(prePath,'HCTSA_D1exc.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1excFile);
    ts_keepIDs = TS_getIDs('control',rawData,'ts');
    D1cntFile = fullfile(prePath,'HCTSA_D1cnt.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1cntFile);
    % Now combine them
    TS_combine(D1excFile,fullfile(prePath,'HCTSA_D1cnt.mat'),false,false,fullfile(prePath,'HCTSA_D1exc_D1cnt.mat'),true);
    case 'D1inh_D1cnt'
    % Isolate D1 excitatory and inhibitory
    ts_keepIDs = TS_getIDs('inhibitory',rawData,'ts');
    D1inhFile = fullfile(prePath,'HCTSA_D1inh.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1inhFile);
    ts_keepIDs = TS_getIDs('control',rawData,'ts');
    D1cntFile = fullfile(prePath,'HCTSA_D1cnt.mat');
    TS_FilterData(rawData,ts_keepIDs,[],D1cntFile);
    % Now combine them
    TS_combine(D1inhFile,fullfile(prePath,'HCTSA_D1cnt.mat'),false,false,fullfile(prePath,'HCTSA_D1inh_D1cnt.mat'),true);
    case 'D1exc_D1inh_D1cnt'
    % already in HCTSA.mat
    end
end


end
