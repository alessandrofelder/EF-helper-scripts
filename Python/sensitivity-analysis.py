# @CommandService cs
# @IOService io
# @OpService ops
# @Context ctxt
# @DisplayService ds
# @ImageJ ij

from net.imagej import DefaultDataset
from net.imagej import ImgPlus
from net.imagej.axis import Axes
from net.imagej.ops.image.histogram import HistogramCreate
from net.imglib2.type.numeric.real import DoubleType

from net.imglib2.histogram import Real1dBinMapper
from net.imglib2.histogram import Histogram1d

from net.imglib2.util import ValuePair
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

thresholds = [0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8]
maxSeedPoints = [100,1000,10000,100000,1000000]
nSearchDirections = [5,10,15,20,25,30]

histoBins = range(-98,102,4)


with open(workingDir+'histo-parameters.csv', mode='w') as parameter_file:
	parameter_writer = csv.writer(parameter_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for image in files:
		for points in maxSeedPoints:
			for threshold in thresholds:
				for nDirections in nSearchDirections:
					sourceName = workingDir+localDir+"../EF/"+image + "_" + str(points) + "_points_" + str(threshold) + "_threshold_" + str(nDirections) + "_directions_"+"-EF.tif";
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

					histoMapper = Real1dBinMapper(-1,1,50,False)
					histo = Histogram1d(histoMapper)
					histo.countData(source)
					print(histoBins)

					histoBinFreqs = histo.toLongArray()
					print(histoBinFreqs)
					histoMults = [histoBinFreqs[i]*histoBins[i]/100.0 for i in range(len(histoBins))]
					print(histoMults)
					total = histo.distributionCount()
					print(total)
					meanEFestimate = sum(histoMults)/total#not exact, based on histo!
					print(meanEFestimate)
					print("done")
					timeTaken = time.time()-startTime
					print(timeTaken)
			
					parameterlist = [source.getName(), points, threshold, nDirections, meanEFestimate];
					parameter_writer.writerow(parameterlist)

					IJ.run("Close All")
					
					

					