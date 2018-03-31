function filteredData = FilterReducedSet(loadedData)

load(fullfile('Data','clusterInfo_HCTSA_rightCTX_4000_0.20.mat'),'autoChosenIDs');

filteredData = loadedData;
keepMe = ismember([loadedData.Operations.ID],autoChosenIDs);

filteredData.Operations = loadedData.Operations(keepMe);
filteredData.TS_DataMat = loadedData.TS_DataMat(:,keepMe);
filteredData.TS_Quality = loadedData.TS_Quality(:,keepMe);

end
