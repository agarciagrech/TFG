
%calculate the index for windows of 4 seconds
function [kSQI_01_vector,sSQI_01_vector, pSQI_01_vector,rel_powerLine01_vector, cSQI_01_vector, basSQI_01_vector,dSQI_01_vector,geometricMean_vector,averageGeometricMean] = IndexForSignalWindows(ECG)
%       ecg = importdata(ECG);
%       ecg_values = ecg.data;
%       data = ecg_values(:,3);

      %coger los datos de ECG de physionet
      ecg = importdata(ECG);
      leadNumber = 10; %desde 2 hasta 13
      data = ecg(:,leadNumber);

      FS_original = originalFS;
      Fs_new = samplingFreq;
      [P,Q] = rat(Fs_new/FS_original);
      data_s = resample(data,P,Q);
      %plot(data_s);

      len = length(data_s);
      window_len = windowSize*Fs_new;
      size_vector = floor((len/window_len));
      kSQI_01_vector =zeros(1,size_vector);
      sSQI_01_vector= zeros(1,size_vector);
      pSQI_01_vector = zeros(1,size_vector);
      rel_powerLine01_vector = zeros(1,size_vector);
      cSQI_01_vector = zeros(1,size_vector);
      basSQI_01_vector = zeros(1,size_vector);
      dSQI_01_vector = zeros(1,size_vector);
      geometricMean_vector = zeros(1,size_vector);

      [qrs,varargout] = pantompkins_qrs(data_s,samplingFreq,logical(0)); 
      qrs_seconds = qrs/samplingFreq;
      qrs_len = length(qrs_seconds);
      qrs_window = [];

      for i=1:floor(len/window_len)
          
         data_f=data_s((i-1)*(window_len)+1:i*(window_len)+1);
         plot(data_f);
         for j=1:(qrs_len-1)
             if qrs_seconds(j) >= ((i-1)*windowSize) && qrs_seconds(j)< (i*windowSize)
                 qrs_window(end+1) = qrs_seconds(j);
             end
         end
     
         %calculamos los índices y le asignamos un valor entreo 0.1 y 1.
         %También la media geométrica 
         [kSQI,sSQI, pSQI, rel_powerLine, cSQI,basSQI] = IndexCalculation(data_f,qrs_window);
         [total_dSQI, cont_dSQI, s_dSQI] = dsqi(data_f, samplingFreq);
         [kSQI_01,sSQI_01, pSQI_01, SQI_rel_powerLine_01, cSQI_01, basSQI_01,dSQI_01,geometricMean] = AssignValueToIndexes(kSQI,sSQI, pSQI, rel_powerLine, cSQI,basSQI,total_dSQI);

         fprintf('%.2f ', [kSQI_01, sSQI_01, pSQI_01, SQI_rel_powerLine_01, cSQI_01, basSQI_01, dSQI_01, geometricMean]);
         fprintf("\n");
        
         if(geometricMean < 0.8)
                      fprintf("\n");
         end

         %metemos el valor en cada uno de los vectores 
         kSQI_01_vector(i) = kSQI_01; 
         sSQI_01_vector(i) = sSQI_01;
         pSQI_01_vector(i) = pSQI_01;
         rel_powerLine01_vector(i) = SQI_rel_powerLine_01;
         cSQI_01_vector(i) = cSQI_01;
         basSQI_01_vector(i) = basSQI_01;
         geometricMean_vector(i) = geometricMean;
         dSQI_01_vector(i)=dSQI_01;
         qrs_window = [];
      end
          averageGeometricMean = mean(geometricMean_vector);
          %upsample de los vectores
          kurtosis_vector_ups = upsampleVector(kSQI_01_vector);
          skewness_vector_ups = upsampleVector(sSQI_01_vector);
          power_vector_ups = upsampleVector(pSQI_01_vector);
          relPowerLine_vector_ups = upsampleVector(rel_powerLine01_vector);
          var_vector_ups = upsampleVector(cSQI_01_vector);
          bas_vector_ups = upsampleVector(basSQI_01_vector);
          geometricMean_vector_ups = upsampleVector(geometricMean_vector);

          showAllPlots = showPlots;
          if(showAllPlots == 1)
          plot(data_s);
          hold on;
          plot(kurtosis_vector_ups*(50000/mean(kSQI_01_vector))); %upsampling del vector y multiplicar 
          title("ECG+Kurtosis");

          figure
          plot(data_s);
          hold on;
          plot(skewness_vector_ups*(50000/mean(sSQI_01_vector)));
          title("ECG+Skewness");

          figure
          plot(data_s);
          hold on;
          plot(power_vector_ups*(50000/mean(pSQI_01_vector)))
          title("ECG+Power");

          figure
          plot(data_s);
          hold on;
          plot(relPowerLine_vector_ups*(50000/mean(rel_powerLine01_vector)))
          title("ECG+Relative PowerLine")

          figure
          plot(data_s);
          hold on;
          plot(var_vector_ups*(50000/mean(cSQI_01_vector)));
          title("ECG+R-RVariability");

          figure
          plot(data_s);
          hold on;
          plot(bas_vector_ups*(50000/mean(basSQI_01_vector)));
          title("ECG+BaseLine");

          figure 
          plot(data_s);
          hold on;
          plot(geometricMean_vector_ups*(50000/mean(geometricMean_vector)));
          title("ECG+GeometricMean")
          end

end

function [vector_ups] = upsampleVector(vector)
    Fs = 1/windowSize;
    Fs_ecg = samplingFreq;
%    [P,Q] = rat(Fs_ecg/Fs);
%    vector_ups = resample(vector,P,Q);
     upsampleFactor = Fs_ecg/Fs;
     vector_ups = upsample(vector,upsampleFactor);
   

end