%calculate index for the complete signal 

function [kSQI_01,sSQI_01, pSQI_01, SQI_rel_powerLine_01,cSQI_01, basSQI_01,dSQI_01,geometricMean,averageIndex] = IndexForCompleteSignal(ECG)
     
     prompt = "If your data is from Bitalino, enter 1, if it is from physionet, enter 2\n ";
   
     x = input(prompt);

     if x == 1
        data = ImportBitalinoData(ECG);
        FS_original = originalFSBitalino;
     elseif x == 2
        data = ImportPhysionetData(ECG);
        FS_original = originalFSPhysionet;
     end
   
      Fs_new = samplingFreq;
      [P,Q] = rat(Fs_new/FS_original);
      data_s = resample(data,P,Q);
      [qrs,varargout] = pantompkins_qrs(data_s,samplingFreq,logical(0));
      qrs_seconds = qrs/samplingFreq;
      plot(data_s);

      [kSQI,sSQI, pSQI, rel_powerLine,cSQI,basSQI] = IndexCalculation(data_s,qrs_seconds); %index calculation
      [total_dSQI, cont_dSQI, s_dSQI] = dsqi(data_s, samplingFreq); %calculate dSQI
      [kSQI_01,sSQI_01, pSQI_01, SQI_rel_powerLine_01,cSQI_01, basSQI_01,dSQI_01,geometricMean] = AssignValueToIndexes(kSQI,sSQI,pSQI, rel_powerLine,cSQI,basSQI,total_dSQI); %translate index value to a value between 0.1 and 1
      indexes = [kSQI_01,sSQI_01,pSQI_01,SQI_rel_powerLine_01,cSQI_01,basSQI_01,dSQI_01];
      averageIndex = mean(indexes);
    
      
end