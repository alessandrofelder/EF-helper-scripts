input_image_dir="/media/alessandro/Seagate Expansion Drive/vertebra-study-small-step-dave/original-images/";
files = getFileList(input_image_dir);
print(files.length);
nReps = 1
for(i=0; i<files.length; i++) {
	print("current file: ", files[i]);
	
	 t0 = getTime();
	for(j=0; j<nReps;j++)
	{
		open(input_image_dir+files[i]);
		run("Structure Model Index", "smi=[Hildebrand & Rüegsegger] voxel=2 mesh=0.500");
		close();
	}
	t1 = getTime();
	print("avg exec time:: ", (t1-t0)/nReps, " ms");
	
	t0 = getTime();
	for(j=0; j<nReps; j++)
	{
		open(input_image_dir+files[i]);
		run("Volume Fraction", "algorithm=Voxel surface=6");
		close();
	}
	t1 = getTime();
	print("avg exec time:: ", (t1-t0)/nReps, " ms");
}
