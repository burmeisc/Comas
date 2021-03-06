#{
Function to compare graphically Diff to MicroDiff in terms of SSE 
#@param file1,2: filenames where file1 is MDAV/Diff and file2 is MicroDiff
#}
function plotComparisonSSE(file1, file2)

filename = [file1 ".txt"];
fid = fopen(filename, "r");
temp1= dlmread(filename);
fclose(fid);

filename = [file2 ".txt"];
fid = fopen(filename, "r");
temp2= dlmread(filename);
fclose(fid);


k = [1:99]';

size(temp2,1)
sseMicroDiff1 = temp2(1:99,3);
sseMicroDiff2 = temp2(100:198,3);
sseMicroDiff3 = temp2(199:297,3);
sseMicroDiff4 = temp2(298:396,3);


SSEDiff1(1:99,1) = temp1(1,2);
SSEDiff2(1:99,1) = temp1(2,2);
SSEDiff3 (1:99,1)= temp1(3,2);
SSEDiff4 (1:99,1)= temp1(4,2);

figure(1)
hold on
title('SSE');
xlabel('k');
plot(k,sseMicroDiff1,'b --', k, sseMicroDiff2,'r:',
       k, sseMicroDiff3,'g-.', k, sseMicroDiff4, 'm-', k, SSEDiff1,'b--', k , 
       SSEDiff2,'r:', k, SSEDiff3, 'g-.',k, SSEDiff4,'m-');
legend({'eps=0.01','eps=0.1','eps=1','eps=10'});
endfunction