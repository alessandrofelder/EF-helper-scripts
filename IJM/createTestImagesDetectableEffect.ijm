
seeds = newArray(23,29,31,7);

for(s = 0; s<4; s++){
	for (i = 3; i <= 5; i++) {
		for (j = 3; j <= 5; j++) {
			for (k = 3; k <= 5; k++) {
				run("Create EF test images", "shortestellipsoiddimension=5.0 imagedimension=200 nspheres="+i+" nrods="+j+" nplates="+k+" nsurfboards=0 randomseed="+seeds[s]);
				selectWindow("Test EF image");
				saveAs("Tiff", "/media/alessandro/CT Ext.HDD002/ale/detectable-effect-study-6-runs/test-images/test-ef-image-dim-200-edim-5-seed-23-"+i+""+j+""+k+".tif");
				run("Close All");
			}
		}
	}
}