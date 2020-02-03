function [prePath,rawData,rawDataBL,dataTime,dataTimeNorm] = GiveMeLeftRightInfo(leftOrRight,whatAnalysis,whatTimePoint)
% Get information on filenames of processed files
%-------------------------------------------------------------------------------

if nargin < 1
    leftOrRight = 'right';
end
if nargin < 2
    whatAnalysis = 'Excitatory_SHAM';
end
if nargin < 3
    whatTimePoint = 'ts2-BL';
end

%-------------------------------------------------------------------------------
% Parent directory
switch leftOrRight
    case 'left'
        prePath = 'HCTSA_LeftdmCP';  %for CAMK and others it is LeftCTX
    case 'right'
        prePath = 'HCTSA_RightdmCP';
    %case 'control'
        %prePath = 'HCTSA_Control';
    otherwise
        error('Unknown region ''%s''',leftOrRight);
end

%-------------------------------------------------------------------------------
% File in parent directory:
fprintf(1,'%s\n',whatAnalysis);
switch whatAnalysis
case 'Excitatory_SHAM'
    rawData = fullfile(prePath,'HCTSA.mat');
    rawDataBL = fullfile(prePath,'HCTSA_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_%s_N.mat',whatTimePoint));
case 'PVCre_SHAM'
    rawData = fullfile(prePath,'HCTSA_PVCre_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_PVCre_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_PVCre_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_PVCre_SHAM_%s_N.mat',whatTimePoint));
case 'CAMK_SHAM'
    rawData = fullfile(prePath,'HCTSA_CAMK_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_CAMK_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_CAMK_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_CAMK_SHAM_%s_N.mat',whatTimePoint));
case 'CAMK_PVCre'
      rawData = fullfile(prePath,'HCTSA_CAMK_PVCre.mat');
      rawDataBL = fullfile(prePath,'HCTSA_CAMK_PVCre_baselineSub.mat');
      dataTime = fullfile(prePath,sprintf('HCTSA_CAMK_PVCre_%s.mat',whatTimePoint));
      dataTimeNorm = fullfile(prePath,sprintf('HCTSA_CAMK_PVCre_%s_N.mat',whatTimePoint));
case 'CAMK_Excitatory'
      rawData = fullfile(prePath,'HCTSA_CAMK_Excitatory.mat');
      rawDataBL = fullfile(prePath,'HCTSA_CAMK_Excitatory_baselineSub.mat');
      dataTime = fullfile(prePath,sprintf('HCTSA_CAMK_Excitatory_%s.mat',whatTimePoint));
      dataTimeNorm = fullfile(prePath,sprintf('HCTSA_CAMK_Excitatory_%s_N.mat',whatTimePoint));
case 'CAMK_Excitatory_PVCre_SHAM'
      rawData = fullfile(prePath,'HCTSA_CAMK_Excitatory_PVCre_SHAM.mat');
      rawDataBL = fullfile(prePath,'HCTSA_CAMK_Excitatory_PVCre_SHAM_baselineSub.mat');
      dataTime = fullfile(prePath,sprintf('HCTSA_CAMK_Excitatory_PVCre_SHAM_%s.mat',whatTimePoint));
      dataTimeNorm = fullfile(prePath,sprintf('HCTSA_CAMK_Excitatory_PVCre_SHAM_%s_N.mat',whatTimePoint));
case 'Excitatory_PVCre'
    rawData = fullfile(prePath,'HCTSA_Exc_PVCre.mat');
    rawDataBL = fullfile(prePath,'HCTSA_Exc_PVCre_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_Exc_PVCre_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_Exc_PVCre_%s_N.mat',whatTimePoint));
case 'Excitatory_PVCre_SHAM'
    rawData = fullfile(prePath,'HCTSA_Exc_PVCre_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_Exc_PVCre_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_Exc_PVCre_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_Exc_PVCre_SHAM_%s_N.mat',whatTimePoint));
case 'SST_SSTcnt'
    rawData = fullfile(prePath,'HCTSA_SST_SSTcnt.mat');
    rawDataBL = fullfile(prePath,'HCTSA_SST_SSTcnt_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_SST_SSTcnt_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_SST_SSTcnt_%s_N.mat',whatTimePoint));
case 'SST_PV'
    rawData = fullfile(prePath,'HCTSA_SST_PV.mat');
    rawDataBL = fullfile(prePath,'HCTSA_SST_PV_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_SST_PV_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_SST_PV_%s_N.mat',whatTimePoint));
case 'SST_SHAM'
    rawData = fullfile(prePath,'HCTSA_SST_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_SST_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_SST_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_SST_SHAM_%s_N.mat',whatTimePoint));
case 'PV_SHAM'
    rawData = fullfile(prePath,'HCTSA_PV_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_PV_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_PV_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_PV_SHAM_%s_N.mat',whatTimePoint));
case 'PV_SSTcnt'
    rawData = fullfile(prePath,'HCTSA_PV_SSTcnt.mat');
    rawDataBL = fullfile(prePath,'HCTSA_PV_SSTcnt_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_PV_SSTcnt_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_PV_SSTcnt_%s_N.mat',whatTimePoint));
case 'SST_SSTcnt_PV_SHAM'
    rawData = fullfile(prePath,'HCTSA_SST_SSTcnt_PV_SHAM.mat');
    rawDataBL = fullfile(prePath,'HCTSA_SST_SSTcnt_PV_SHAM_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_SST_SSTcnt_PV_SHAM_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_SST_SSTcntPV_SHAM_%s_N.mat',whatTimePoint));

%For D1 analysis there is only left and right for now
case 'D1exc_D1inh'
    rawData = fullfile(prePath,'HCTSA_D1exc_D1inh.mat');
    rawDataBL = fullfile(prePath,'HCTSA_D1exc_D1inh_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_D1exc_D1inh_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_D1exc_D1inh_%s_N.mat',whatTimePoint));
case 'D1exc_D1cnt'
    rawData = fullfile(prePath,'HCTSA_D1exc_D1cnt.mat');
    rawDataBL = fullfile(prePath,'HCTSA_D1exc_D1cnt_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_D1exc_D1cnt_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_D1exc_D1cnt_%s_N.mat',whatTimePoint));
case 'D1inh_D1cnt'
    rawData = fullfile(prePath,'HCTSA_D1inh_D1cnt.mat');
    rawDataBL = fullfile(prePath,'HCTSA_D1inh_D1cnt_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_D1inh_D1cnt_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_D1inh_D1cnt_%s_N.mat',whatTimePoint));
case 'D1exc_D1inh_D1cnt'
    rawData = fullfile(prePath,'HCTSA_D1exc_D1inh_D1cnt.mat');
    rawDataBL = fullfile(prePath,'HCTSA_D1exc_D1inh_D1cnt_baselineSub.mat');
    dataTime = fullfile(prePath,sprintf('HCTSA_D1exc_D1inh_D1cnt_%s.mat',whatTimePoint));
    dataTimeNorm = fullfile(prePath,sprintf('HCTSA_D1exc_D1inh_D1cnt_%s_N.mat',whatTimePoint));
otherwise
    error('Unknown analysis: %s',whatAnalysis);
end

end
