# trace generated using paraview version 5.5.0-RC3-111-g1aabbaa

#
from os import listdir

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

directory = '/media/alessandro/Seagate Expansion Drive/distance-ridge-study/seeds/'

for filename in listdir(directory):
    if filename.endswith(".tif"): 
		name = filename
		# create a new 'TIFF Series Reader'
		image = TIFFSeriesReader(FileNames=[directory+name])

		# get active view
		renderView1 = GetActiveViewOrCreate('RenderView')
		# uncomment following to set a specific view size
		# renderView1.ViewSize = [984, 961]

		# show data in view
		imageDisplay = Show(image, renderView1)

		# trace defaults for the display properties.
		imageDisplay.Representation = 'Outline'
		imageDisplay.ColorArrayName = ['POINTS', '']
		imageDisplay.OSPRayScaleArray = 'Tiff Scalars'
		imageDisplay.OSPRayScaleFunction = 'PiecewiseFunction'
		imageDisplay.SelectOrientationVectors = 'None'
		imageDisplay.ScaleFactor = 0.0114
		imageDisplay.SelectScaleArray = 'Tiff Scalars'
		imageDisplay.GlyphType = 'Arrow'
		imageDisplay.GlyphTableIndexArray = 'Tiff Scalars'
		imageDisplay.GaussianRadius = 0.0005700000000000001
		imageDisplay.SetScaleArray = ['POINTS', 'Tiff Scalars']
		imageDisplay.ScaleTransferFunction = 'PiecewiseFunction'
		imageDisplay.OpacityArray = ['POINTS', 'Tiff Scalars']
		imageDisplay.OpacityTransferFunction = 'PiecewiseFunction'
		imageDisplay.DataAxesGrid = 'GridAxesRepresentation'
		imageDisplay.SelectionCellLabelFontFile = ''
		imageDisplay.SelectionPointLabelFontFile = ''
		imageDisplay.PolarAxes = 'PolarAxesRepresentation'
		imageDisplay.ScalarOpacityUnitDistance = 0.0017320807447898901
		imageDisplay.IsosurfaceValues = [0.5]
		imageDisplay.Slice = 57

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		imageDisplay.DataAxesGrid.XTitleColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.XTitleFontFile = ''
		imageDisplay.DataAxesGrid.YTitleColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.YTitleFontFile = ''
		imageDisplay.DataAxesGrid.ZTitleColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.ZTitleFontFile = ''
		imageDisplay.DataAxesGrid.XLabelColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.XLabelFontFile = ''
		imageDisplay.DataAxesGrid.YLabelColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.YLabelFontFile = ''
		imageDisplay.DataAxesGrid.ZLabelColor = [0.0, 0.0, 0.0]
		imageDisplay.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		imageDisplay.PolarAxes.PolarAxisTitleColor = [0.0, 0.0, 0.0]
		imageDisplay.PolarAxes.PolarAxisTitleFontFile = ''
		imageDisplay.PolarAxes.PolarAxisLabelColor = [0.0, 0.0, 0.0]
		imageDisplay.PolarAxes.PolarAxisLabelFontFile = ''
		imageDisplay.PolarAxes.LastRadialAxisTextColor = [0.0, 0.0, 0.0]
		imageDisplay.PolarAxes.LastRadialAxisTextFontFile = ''
		imageDisplay.PolarAxes.SecondaryRadialAxesTextColor = [0.0, 0.0, 0.0]
		imageDisplay.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# update the view to ensure updated data information
		renderView1.Update()

		# Properties modified on image
		image.UseCustomDataSpacing = 1
		image.CustomDataSpacing = [1.0, 1.0, 1.0]

		# update the view to ensure updated data information
		renderView1.Update()

		# create a new 'Threshold'
		threshold2 = Threshold(Input=image)
		threshold2.Scalars = ['POINTS', 'Tiff Scalars']
		threshold2.ThresholdRange = [0.0, 1.0]

		# Properties modified on threshold2
		threshold2.ThresholdRange = [0.1, 1.0]

		# show data in view
		threshold2Display = Show(threshold2, renderView1)

		# trace defaults for the display properties.
		threshold2Display.Representation = 'Surface'
		threshold2Display.ColorArrayName = [None, '']
		threshold2Display.OSPRayScaleFunction = 'PiecewiseFunction'
		threshold2Display.SelectOrientationVectors = 'None'
		threshold2Display.ScaleFactor = -2.0000000000000002e+298
		threshold2Display.SelectScaleArray = 'None'
		threshold2Display.GlyphType = 'Arrow'
		threshold2Display.GlyphTableIndexArray = 'None'
		threshold2Display.GaussianRadius = -1e+297
		threshold2Display.SetScaleArray = [None, '']
		threshold2Display.ScaleTransferFunction = 'PiecewiseFunction'
		threshold2Display.OpacityArray = [None, '']
		threshold2Display.OpacityTransferFunction = 'PiecewiseFunction'
		threshold2Display.DataAxesGrid = 'GridAxesRepresentation'
		threshold2Display.SelectionCellLabelFontFile = ''
		threshold2Display.SelectionPointLabelFontFile = ''
		threshold2Display.PolarAxes = 'PolarAxesRepresentation'

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		threshold2Display.DataAxesGrid.XTitleColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.XTitleFontFile = ''
		threshold2Display.DataAxesGrid.YTitleColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.YTitleFontFile = ''
		threshold2Display.DataAxesGrid.ZTitleColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.ZTitleFontFile = ''
		threshold2Display.DataAxesGrid.XLabelColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.XLabelFontFile = ''
		threshold2Display.DataAxesGrid.YLabelColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.YLabelFontFile = ''
		threshold2Display.DataAxesGrid.ZLabelColor = [0.0, 0.0, 0.0]
		threshold2Display.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		threshold2Display.PolarAxes.PolarAxisTitleColor = [0.0, 0.0, 0.0]
		threshold2Display.PolarAxes.PolarAxisTitleFontFile = ''
		threshold2Display.PolarAxes.PolarAxisLabelColor = [0.0, 0.0, 0.0]
		threshold2Display.PolarAxes.PolarAxisLabelFontFile = ''
		threshold2Display.PolarAxes.LastRadialAxisTextColor = [0.0, 0.0, 0.0]
		threshold2Display.PolarAxes.LastRadialAxisTextFontFile = ''
		threshold2Display.PolarAxes.SecondaryRadialAxesTextColor = [0.0, 0.0, 0.0]
		threshold2Display.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# update the view to ensure updated data information
		renderView1.Update()

		# Properties modified on threshold2
		threshold2.AllScalars = 0

		# update the view to ensure updated data information
		renderView1.Update()

		# Properties modified on threshold2Display
		threshold2Display.SetScaleArray = [None, 'Tiff Scalars']

		# Properties modified on threshold2Display
		threshold2Display.OpacityArray = [None, 'Tiff Scalars']

		# Properties modified on threshold2Display
		threshold2Display.OSPRayScaleArray = 'Tiff Scalars'

		# set scalar coloring
		ColorBy(threshold2Display, ('POINTS', 'Tiff Scalars'))

		# rescale color and/or opacity maps used to include current data range
		threshold2Display.RescaleTransferFunctionToDataRange(True, False)

		# show color bar/color legend
		threshold2Display.SetScalarBarVisibility(renderView1, True)

		# get color transfer function/color map for 'TiffScalars'
		tiffScalarsLUT = GetColorTransferFunction('TiffScalars')
		tiffScalarsLUT.RGBPoints = [0.0, 0.231373, 0.298039, 0.752941, 127.515625, 0.865003, 0.865003, 0.865003, 255.03125, 0.705882, 0.0156863, 0.14902]
		tiffScalarsLUT.ScalarRangeInitialized = 1.0

		# Hide the scalar bar for this color map if no visible data is colored by it.
		HideScalarBarIfNotNeeded(tiffScalarsLUT, renderView1)

		# change solid color
		threshold2Display.DiffuseColor = [0.0, 0.6666666666666666, 1.0]

		#### saving camera placements for all active views

		# current camera placement for renderView1
		renderView1.CameraPosition = [-77.69487077623245, 249.8427754009121, -242.28680732336272]
		renderView1.CameraFocalPoint = [56.75, 56.75, 57.25]
		renderView1.CameraViewUp = [0.32747051996825033, 0.8542710614413801, 0.4037127842111787]
		renderView1.CameraParallelScale = 98.5834037756863

		# reset view to fit data
		renderView1.ResetCamera()
		

		# save screenshot
		SaveScreenshot(directory+name+'-test-bla.png', renderView1, ImageResolution=[984, 961], 
		    # PNG options
		    CompressionLevel='0')

		Delete(threshold2)
		del threshold2

		Delete(image)
		del image
		
