# @CommandService cs
# @IOService io
# @Context ctxt
# @DisplayService ds
# @ImageJ ij

from net.imagej import DefaultDataset
from net.imagej import ImgPlus
from net.imagej.axis import Axes
from io.scif.img import ImgOpener
from net.imglib2.img import Img
from ij import IJ

import os
import time
import csv

workingDir = "/home/alessandro/Documents/code/EF-test-images/"
localDir = "sensitivity-test-images/"
files = os.listdir(workingDir+localDir)
print(len(files))

thresholds = [0.5, 0.6, 0.7, 0.8]
maxSeedPoints = [100,1000,10000,100000]
nSearchDirections = [10,20,40]

with open(workingDir+'parameters.csv', mode='w') as parameter_file:
	parameter_writer = csv.writer(parameter_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for image in files:
		for points in maxSeedPoints:
			for threshold in thresholds:
				for nDirections in nSearchDirections:
					sourceName = workingDir+localDir+image;
					print(sourceName);
					startTime = time.time()
					i = ImgOpener();
					sourceImg = i.openImgs(sourceName).get(0)
					axes = [Axes.X, Axes.Y, Axes.Z]
					calibration = [1,1,1]
					units = ["","",""]
					source = ImgPlus(sourceImg,image,axes,calibration,units)
					name = source.getName()
					name = name + "_" + str(points) + "_points_" + str(threshold) + "_threshold_" + str(nDirections) + "_directions_"  
					wrapper = cs.run("org.bonej.wrapperPlugins.EllipsoidFactorWrapper",True,["inputImage",source,"nSphere", nDirections, "approximateMaximumNumberOfSeeds", points, "thresholdForBeingARidgePoint", threshold, "showSecondaryImages",True])
					wrapperInstance = wrapper.get()
					EF = wrapperInstance.getOutput("efImage")
			
					d = DefaultDataset(ctxt,EF) 
					io.save(d, workingDir+"/EF/"+name+"-EF.tif")
					timeTaken = time.time()-startTime
					print(timeTaken)
			
					ID = wrapperInstance.getOutput("eIdImage")
					#RP = wrapperInstance.getOutput("seedPointsImage")
					d = DefaultDataset(ctxt,ID)
					io.save(d, workingDir+"/ID/"+name+"-ID.tif")
					#d = DefaultDataset(ctxt,RP)
					#io.save(d, workingDir+"/ridge/"+name+"-RP.tif")
					parameterlist = [source.getName(), points, threshold, nDirections, timeTaken];
					parameter_writer.writerow(parameterlist)

					IJ.run("Close All")
					
					

					