
input_image_dir="/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step-dave/original-images/";
files = getFileList(input_image_dir);
print(files.length);
nReps = 1
for(i=0; i<files.length; i++) {
	print("current file: ", files[i]);
	t0 = getTime();
	for(j=0; j<nReps; j++)
	{
		open(input_image_dir+files[i]);
		run("Thickness", "thickness");
		close();
	}
	t1 = getTime();
	print("avg exec time:: ", (t1-t0)/nReps, " ms");
}
