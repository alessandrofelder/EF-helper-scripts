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
import datetime
import csv

workingDir = "/home/alessandro/Documents/code/EF-test-images/"
localDir = "quick-binary-images/"
files = os.listdir(workingDir+localDir)
print(len(files))

nDirections = [10,50,100]
skipRatios = [10,50,100]

with open(workingDir+'parameters.csv', mode='w') as parameter_file:
	parameter_writer = csv.writer(parameter_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	parameterlist = ["iterating over nDirections ", nDirections, " and skipRatios ", skipRatios];
	parameter_writer.writerow(parameterlist)
	for image in files:
		for directions in nDirections:
			for skipRatio in skipRatios:
				try: 
					sourceName = workingDir+localDir+image;
					i = ImgOpener();
					print(i)
					print(sourceName);
					print("directions = ", directions, " skipRatio = ", skipRatio)
					sourceImg = i.openImgs(sourceName).get(0)
					print(sourceImg)
					axes = [Axes.X, Axes.Y, Axes.Z]
					calibration = [1,1,1]
					units = ["","",""]
					source = ImgPlus(sourceImg,image,axes,calibration,units)
					#ds.createDisplay(source)
					name = source.getName()
					name = name + "_dir_" + str(directions) + "_sr_"+str(skipRatio)
					startTime = time.time()
					wrapper = cs.run("org.bonej.wrapperPlugins.EllipsoidFactorWrapper",False,["inputImgPlus",source,"nVectors", directions, "vectorIncrement", 1/2.3, "skipRatio",skipRatio,"contactSensitivity",1,"maxIterations",100, "maxDrift",1.73,"sigma",0,"showSecondaryImages",True])
					wrapperInstance = wrapper.get()
					EF = wrapperInstance.getOutput("efImage")
					timeTaken = time.time()-startTime
					print("done")
					print(timeTaken)
					table = wrapperInstance.getOutput("resultsTable")
					print(table)
					print(table[0])
					print(len(table))
					d = DefaultDataset(ctxt,EF) 
					io.save(d, "/media/alessandro/A6E8FE87E8FE5551/Users/afelder/Desktop/EF-ported/"+name+"-EF.tif")
				
					parameterlist = [source.getName(), directions, timeTaken];
					parameter_writer.writerow(parameterlist)
					
					IJ.run("Close All")	
				except:
					print("!!!exception at file = ", workingDir+localDir+image, ", directions = ", directions, ", skipRatio = ", skipRatio, "!!!")
					pass
					

					