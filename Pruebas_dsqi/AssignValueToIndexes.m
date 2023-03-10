%assign a value between 0.1-1 to each of the indexes and calculate the
%geometric mean
function [kSQI_01,sSQI_01, pSQI_01, SQI_rel_powerLine_01, cSQI_01, basSQI_01,dSQI_01,geometricMean] = AssignValueToIndexes(kSQI,sSQI, pSQI, rel_powerLine, cSQI, basSQI,total_dSQI)
   y = [lowerLimit 1]; %vector para interpolation
   %for kSQI
   x_k = [2.5 5.01];
   if kSQI<=2.5
     kSQI_01 = lowerLimit;
   elseif kSQI>5
      kSQI_01 =1;
   else
      kSQI_01 = interp1(x_k,y,kSQI);
   end

   %for sSQI
   x_s = [-0.1 2.0];
   if sSQI<-0.1
       sSQI_01 = lowerLimit;
   elseif sSQI>2
       sSQI_01 = 1;
   else
       sSQI_01 = interp1(x_s,y,sSQI);
   end

   %for pSQI
   x_p1 = [0.9 0.8];
   x_p2 = [0.15 0.5];
   if pSQI>=0.9 
       pSQI_01 = lowerLimit;
   elseif pSQI<0.15
       pSQI_01 = lowerLimit;
   elseif pSQI>= 0.5 && pSQI< 0.8
       pSQI_01 = 1;
   elseif pSQI>= 0.8 && pSQI<0.9
       pSQI_01 = interp1(x_p1,y,pSQI);
   else
       pSQI_01 = interp1(x_p2,y,pSQI);
   end

   % for rel_powerLine SQI_rel_powerLine
   x_rp = [0.5 0.001];
   if rel_powerLine < 0.001
       SQI_rel_powerLine_01 = 1;
   elseif rel_powerLine > 0.75
       SQI_rel_powerLine_01 = 0;
   elseif rel_powerLine > 0.5
       SQI_rel_powerLine_01 = 0.1;
   else
       SQI_rel_powerLine_01 = interp1(x_rp,y, rel_powerLine);
   end
   %for cSQI
   x_c = [0.65 0.25];
   if cSQI> 0.65
       cSQI_01 = lowerLimit;
   elseif cSQI<0.25
       cSQI_01 = 1;
   else
       cSQI_01 = interp1(x_c,y,cSQI);
   end

   %for basSQI
   x_b = [0.6 0.95];
   if basSQI<0.6
       basSQI_01 = 0.1;
   elseif basSQI>0.95
       basSQI_01 = 1;
   else
       basSQI_01 = interp1(x_b,y,basSQI);
   end

   %for dSQI
   if total_dSQI==0
       dSQI_01=0.1;%lowerLimit; %si es 0 de momento ponemos 0.1
   else
      dSQI_01 = total_dSQI;
   end

   %calculate the geometric mean between the indexes 
   %index_product = kSQI_01*sSQI_01*pSQI_01*SQI_rel_powerLine_01*cSQI_01*basSQI_01*dSQI_01;
   %geometricMean = (index_product)^(1/7);

   % exponet m_order
   m_order=3;
   index_product = kSQI_01^m_order*sSQI_01^m_order*pSQI_01^m_order*SQI_rel_powerLine_01^m_order*cSQI_01^m_order*basSQI_01^m_order*dSQI_01^m_order;
   geometricMean = (index_product)^(1/(7*m_order));
end

function lower_limit = lowerLimit  %usamos de momento 0.1 como valor m??nimo para los ??ndices
    lower_limit = 0;
end 