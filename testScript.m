function testScript(file,c1,c2, runNumber)

#script for comparing the algorithms MDAV,MicroDiff and justDiff
#@param file: filename
#@param k: clustersize (relevant for MDAV and MicroDiff)
#@param eps: epsilon, relavant for MicroDiff and justDiff
#@param c1,c2: columns for the attributes

debug_on_warning(1);
debug_on_error(1);

%{
#evaluation for e-differntial privacy for epsilon ={0.01,0.1,1,10}
evalDiff = [];
output = ['evalDiff' num2str(file) num2str(runNumber) '.txt'];
eps = {0.01,0.1,1,10};
for i=1:4
  
  [Masked,Origin] = only_diff(eps{i}, file, c1, c2);
  infoLossDiff = infoLoss_diff(Origin, Masked);
  rlDiff = disclosureRisk_diffPrivacy(Origin, Masked);
  evalDiff = [evalDiff ; [eps{i},infoLossDiff,rlDiff]];
  
  save ("-ascii", output ,"evalDiff");
endfor
  
  


#run evaluation for MDAV, for k from 2 to 100
evalMDAV = [];
output = ['evalMDAV' num2str(file) num2str(runNumber) '.txt'];
for k=2:100

  [clusterContainer, Masked, originalValues, Average] = sensitive_MDAV(k, file, c1, c2);
  infoLossMDAV = infoLoss_MDAV(clusterContainer, Average);
  rlMDAV = disclosureRisk_MDAV(originalValues,Masked);
  evalMDAV = [evalMDAV ; [k,infoLossMDAV,rlMDAV]];
   
  save ("-ascii", output, "evalMDAV");

  
endfor


%}

#evaluation for Microaggreagation+Differential Privacy
evalMicroDiff = [];
 output = ['evalMicroDiff' num2str(file) num2str(runNumber) '.txt'];
eps = {0.01,0.1,1,10};
for i=1:4
    #change k depending on dataset, bigger for bigger datasets
  for k=2:100
    [Masked,OriginValues,Clusters,Average] = MicroDiff(k,eps{i}, file, c1, c2);
    #infoLoss = infoLoss_k(Origin, Masked, IndexList);
    #rl = disclosureRisk_MicroDiff(Origin, Masked, IndexList);
    infoLoss = infoLoss_MDAV(Clusters,Average);
    rl = disclosureRisk_MDAV(OriginValues, Masked)
    evalMicroDiff = [evalMicroDiff ; [k, eps{i},infoLoss,rl]];

    save ("-ascii", output, "evalMicroDiff");
  endfor
endfor
  
  
endfunction

