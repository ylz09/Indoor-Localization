calPdf.m : 	
	Function;
	To calculate the pdf of certain AP at a landmark;
	Usage: used in batchImport.m

batchImport.m:	
	Function;
	Import the files in a batch 
	And calculate the distribution map whose elements are paramter of the normal distribution(mean,std);
	Usage: 
		2 input parameter, matrix and input path
		1 output: pdf matrix

distribution.mat
	Pdf Matrix;
	F: [78x53x2 double];
	78 landmarks;
	53 APs;
	mean and std;
	Usage: load distribution.mat

