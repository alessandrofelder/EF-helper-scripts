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

workingDir = "/media/alessandro/Seagate Expansion Drive/disuse-study-final/"
localDir = "thresholded-stacks-75/"
files = os.listdir(workingDir+localDir)
print(len(files))

#nSearchDirections = [10,20,40,80,160]

histoBins = range(-98,102,4)

parameter_file = open(workingDir+'histo-parameters-disuse-test-EF.csv', mode='w') 
parameter_writer = csv.writer(parameter_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
parameter_writer.writerow(["name",histoBins])
for image in files:
	sourceName = workingDir+"EF/"+image + "-runs-6-weighted-1-maxShift-1-vectors-100-ratio-1-maxIts-50-filter-0-contact-5-step-0.217391304348" + "-EF.tif";
	print(sourceName);
	
	startTime = time.time()
	i = ImgOpener();
	sourceImg = i.openImgs(sourceName).get(0)
	axes = [Axes.X, Axes.Y, Axes.Z]
	calibration = [1,1,1]
	units = ["","",""]
	source = ImgPlus(sourceImg,image,axes,calibration,units)
	name = source.getName()

	histoMapper = Real1dBinMapper(-1,1,50,False)
	histo = Histogram1d(histoMapper)
	histo.countData(source)
	print(histoBins)

	histoBinFreqs = histo.toLongArray()
	print("freq: ",histoBinFreqs)
	histoMults = [abs(histoBinFreqs[i]*histoBins[i]/100.0) for i in range(len(histoBins))]
	print(histoMults)
	total = histo.distributionCount()
	print(total)
	meanEFestimate = sum(histoMults)/total#not exact, based on histo!
	print(meanEFestimate)
	print("done")
	timeTaken = time.time()-startTime
	print(timeTaken)

	parameterlist = [source.getName(), histoBinFreqs];
	parameter_writer.writerow(parameterlist)

	print("done writing")
	IJ.run("Close All")

print("done with everything")
					

					
