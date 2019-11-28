# @CommandService cs
# @IOService io
# @Context ctxt
# @UIService ui


from net.imagej import DefaultDataset
from net.imagej import ImgPlus
from net.imagej.axis import Axes
from net.imagej.display import SelectWindow

from io.scif.img import ImgOpener
from net.imglib2.img import Img
from org.bonej.utilities import SharedTable

from ij import IJ

import os
import time
import datetime
workingDir =  "/media/alessandro/Seagate Expansion Drive/test-image-study/"
#workingDir =  "/media/alessandro/CT Ext.HDD002/ale/detectable-effect-study-6-runs/"
#workingDir = "/home/alessandro/Documents/code/EF-test-images/"
outputDir = "/media/alessandro/Seagate Expansion Drive/"
print(os.listdir(workingDir))
#localDir = u'test-images//'
localDir = u'original-images//'
files = os.listdir(workingDir+localDir)
print(len(files))
print(files)

#wanted
reps = [1]
was = [1]
maxShifts = [1]
nVectors = [100]
skipRatios = [2]
maxIterations = [50]
filters = [0]
contacts = [1]
steps = [1]
topologyBools = [False]
distanceThresholds = [0.3,0.4,0.5,0.6,0.7,0.8,0.9]

logfilename = outputDir+'logfile-'+str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))+'.txt'
f = open(logfilename, 'wb')
f.write("#log file for EF script run "+str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
f.write("  --  all combinations of the following will be run:\n")
f.write("#files"+str(files)+"\n")
f.write("#average over runs:"+str(reps)+"\n")
f.write("#weighted averaging depth:"+str(was)+"\n")
f.write("#maximal shifts:"+str(maxShifts)+"\n")
f.write("#number of scouting vectors:"+str(nVectors)+"\n")
f.write("#seed point skipping:"+str(skipRatios)+"\n")
f.write('#\n')
f.write("file,runs,weighted,shift,vectors,skipRatio,maxIterations,time,filter,contact,step\n")
f.close()

cleaner = cs.run("org.bonej.wrapperPlugins.tableTools.SharedTableCleaner", False)
for image in files:
	for rep in reps:
		for wa in was:
			for maxShift in maxShifts:
				for vectors in nVectors:
					for ratio in skipRatios:
						for iterations in maxIterations:
							for filterB in filters:
								for contact in contacts:
									for step in steps:
										for topologyBool in topologyBools:
											for distanceThreshold in distanceThresholds:
												f = open(logfilename, 'ab')
												sourceName = workingDir+localDir+image
												print(sourceName)
												print(rep)
												i = ImgOpener();
												sourceImg = i.openImgs(sourceName).get(0)
												axes = [Axes.X, Axes.Y, Axes.Z]
												calibration = [1,1,1]
												units = ["","",""]
												source = ImgPlus(sourceImg,image,axes,calibration,units)
												name = source.getName()
												print("name: "+name)
												imp = IJ.openImage(sourceName) # need for skeletonization
												imp.show()
												name = name+"-runs-"+str(rep)+"-weighted-"+str(wa)+"-maxShift-"+str(maxShift)+"-vectors-"+str(vectors)+"-ratio-"+str(ratio)+"-maxIts-"+str(iterations)+"-filter-"+str(filterB)+"-contact-"+str(contact)+"-step-"+str(step*1.0/2.3)+"-topo-"+str(topologyBool)+"-distThrsh-"+str(distanceThreshold)
												
												startTime = time.time()
												wrapper = cs.run("org.bonej.wrapperPlugins.EllipsoidFactorWrapper",False,["inputImgPlus",source,"nVectors", vectors, "vectorIncrement", step*1.0/2.3, "skipRatio",ratio,"contactSensitivity",contact,"maxIterations",iterations, "maxDrift",maxShift*1.73,"minimumSemiAxis",filterB,"seedOnDistanceRidge",True,"seedOnTopologyPreserving",topologyBool,"showSecondaryImages",True,"runs",rep,"weightedAverageN",wa,"distanceThreshold",distanceThreshold])
												wrapperInstance = wrapper.get()
												outputs = wrapperInstance.getOutput("ellipsoidFactorOutputImages");
												seeds = wrapperInstance.getOutput("seedPointImage");
												parameters = [image,rep,wa,maxShift,vectors,ratio,iterations,filterB,contact,distanceThreshold, topologyBool, time.time()-startTime]
												
												print(len(outputs))
												EF = outputs.get(0)# 0 item is EF image
												imp.close()
												
												for p in parameters:
													f.write(str(p)+", ")
												f.write('\n')
												f.close()
																	    
												print(time.time()-startTime)
												
												d = DefaultDataset(ctxt,EF) 
												io.save(d, outputDir+"/EF-test/"+name+"-EF.tif")
												AB = outputs.get(6)
												d = DefaultDataset(ctxt,AB)
												io.save(d, outputDir+"/AB-test/"+name+"-AB.tif")
												BC = outputs.get(7)
												d = DefaultDataset(ctxt,BC)
												io.save(d, outputDir+"/BC-test/"+name+"-BC.tif")
												
												A = outputs.get(3)
												d = DefaultDataset(ctxt,A)
												io.save(d, outputDir+"/A-test/"+name+"-A.tif")
												B = outputs.get(4)
												d = DefaultDataset(ctxt,B)
												io.save(d, outputDir+"/B-test/"+name+"-B.tif")
												C = outputs.get(5)
												d = DefaultDataset(ctxt,C)
												io.save(d, outputDir+"/C-test/"+name+"-C.tif")
						
												d = DefaultDataset(ctxt,seeds)
												io.save(d, outputDir+"/seed-test/"+name+"-seeds.tif")
												
												FlinnPeaks = outputs.get(9)
												d = DefaultDataset(ctxt,FlinnPeaks)
												io.save(d, outputDir+"/peak-test/"+name+"-peaks.tif")
												
												print("Done with "+str(parameters))
											
	
table = SharedTable.getTable()
print(table)
f = open(logfilename+"-table", 'wb')
f.write('\n')
f.write("rowname,")

for j in range(0,len(table[0])):
	f.write(table.getRowHeader(j)+",")
		
f.write('\n')

for i in range(0,len(table)):
	f.write(table.getColumnHeader(i)+",")
	for j in range(0,len(table[i])):
		f.write(str(table[i][j])+",")
	f.write('\n')
f.close()