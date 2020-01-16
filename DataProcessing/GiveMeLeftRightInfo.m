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
        prePath = 'HCTSA_LeftCTX';
    case 'right'
        prePath = 'HCTSA_RightCTX';
    case 'control'
        prePath = 'HCTSA_Control';
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
      dataTime = fullfile(prePath,sprintf('HCTSA_CAMK_Excitatory_baselineSub%s.mat',whatTimePoint));
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

otherwise
    error('Unknown analysis: %s',whatAnalysis);
end

end
