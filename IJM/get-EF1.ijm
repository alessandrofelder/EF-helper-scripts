input_image_dir="/home/alessandro/Documents/code/EF-test-images/quick-binary-images/";
output_image_dir="/media/alessandro/A6E8FE87E8FE5551/Users/afelder/Desktop/EF1/";
files = getFileList(input_image_dir);
print(files.length)

for(i=0; i<files.length; i++) {
	print(files[i]);	
	t0 = getTime();
	open(input_image_dir+files[i]);
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	//run("Properties...", "channels=1 slices=100 frames=1 unit=µm pixel_width=5.0000 pixel_height=5.0000 voxel_depth=5.0000 global");
	run("Ellipsoid Factor", "sampling_increment=0.435 vectors=100 skeleton_points=1 contact=1 maximum_iterations=100 maximum_drift=1.73205 maximum_drift=1.73205 ef_image gaussian_sigma=2");		
	t1 = getTime();
	print("done");
	selectWindow("EF-"+files[i]);
	save(output_image_dir+"EF1-"+files[i]);
	close("*");
	print("exec time:: ", (t1-t0), " ms");
}
