

%Tela 1 sin gel 
files = {'Tela1-SG/Tela1_hora0_andando_SinGel.txt','Tela1-SG/Tela1_hora0_escaleras_SinGel.txt','Tela1-SG/Tela1_hora0_trabajando_SinGel.txt','Tela1-SG/Tela1_hora1_andando_SinGel.txt','Tela1-SG/Tela1_hora1_escaleras_SinGel.txt','Tela1-SG/Tela1_hora1_trabajando_SinGel.txt','Tela1-SG/Tela1_hora2_andando_SinGel.txt','Tela1-SG/Tela1_hora2_escaleras_SinGel.txt','Tela1-SG/Tela1_hora2_trabajando_SinGel.txt','Tela1-SG/Tela1_hora3_andando_SinGel.txt','Tela1-SG/Tela1_hora3_escaleras_SinGel.txt','Tela1-SG/Tela1_hora3_trabajando_SinGel.txt'};
for i = 1:length(files) 
     file = files{i} ;
     [filepath,name,ext] = fileparts(file);
     [kSQI_01_v,sSQI_01_v, pSQI_01_v, SQI_rel_powerLine_01_v,cSQI_01_v, basSQI_01_v,dSQI_01_v,geometricMean_V,averageGeometricMean] = IndexForSignalWindows(ImportBitalinoData(file), originalFSBitalino);
     fprintf("Indexes for %s :  averageGeometricMean: %f \n ",file,averageGeometricMean);
end

%Tela 2 sin gel 
files = {'Tela2-SG/Tela2_hora0_andando_SinGel.txt','Tela2-SG/Tela2_hora0_escaleras_SinGel.txt','Tela2-SG/Tela2_hora0_trabajando_SinGel.txt','Tela2-SG/Tela2_hora1_andando_SinGel.txt','Tela2-SG/Tela2_hora1_escaleras_SinGel.txt','Tela2-SG/Tela2_hora1_trabajando_SinGel.txt','Tela2-SG/Tela2_hora2_andando_SinGel.txt','Tela2-SG/Tela2_hora2_escaleras_SinGel.txt','Tela2-SG/Tela2_hora2_trabajando_SinGel.txt','Tela2-SG/Tela2_hora3_andando_SinGel.txt','Tela2-SG/Tela2_hora3_escaleras_SinGel.txt','Tela2-SG/Tela2_hora3_trabajando_SinGel.txt'};
for i = 1:length(files) 
     file = files{i} ;
     [filepath,name,ext] = fileparts(file);
     [kSQI_01_v,sSQI_01_v, pSQI_01_v, SQI_rel_powerLine_01_v,cSQI_01_v, basSQI_01_v,dSQI_01_v,geometricMean_V,averageGeometricMean] = IndexForSignalWindows(ImportBitalinoData(file), originalFSBitalino);
     fprintf("Indexes for %s :  averageGeometricMean: %f \n ",file,averageGeometricMean);
end

%Tela 3 sin gel 