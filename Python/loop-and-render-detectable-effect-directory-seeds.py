# trace generated using paraview version 5.5.0-RC3-111-g1aabbaa

#
from os import listdir

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

directory = '/media/alessandro/Seagate Expansion Drive/detectable-effect-study-6-runs/seeds/'

seeds =  ['23','31','7']
codes = ['500','050','005','550','505','055','555']

for s in seeds:
	for c in codes:
		name = 'test-ef-image-dim-200-edim-5-seed-'+s+'-'+c+'.tif-runs-1-weighted-1-maxShift-300-vectors-4-ratio-10-seeds.tif'
		# create a new 'TIFF Series Reader'
		image = TIFFSeriesReader(FileNames=[directory+name])
		# find source
		binaryImageruns1weighted1maxShift300vectors4ratio10seedstif = FindSource(name)

		# create a new 'Threshold'
		threshold1 = Threshold(Input=binaryImageruns1weighted1maxShift300vectors4ratio10seedstif)
		threshold1.Scalars = ['POINTS', 'Tiff Scalars']
		threshold1.ThresholdRange = [0.0, 1.0]

		# Properties modified on threshold1
		threshold1.ThresholdRange = [1.0, 255.0]

		# get active view
		renderView1 = GetActiveViewOrCreate('RenderView')
		# uncomment following to set a specific view size
		# renderView1.ViewSize = [984, 961]

		# show data in view
		threshold1Display = Show(threshold1, renderView1)

		# trace defaults for the display properties.
		threshold1Display.Representation = 'Surface'
		threshold1Display.ColorArrayName = [None, '']
		threshold1Display.OSPRayScaleFunction = 'PiecewiseFunction'
		threshold1Display.SelectOrientationVectors = 'None'
		threshold1Display.ScaleFactor = -2.0000000000000002e+298
		threshold1Display.SelectScaleArray = 'None'
		threshold1Display.GlyphType = 'Arrow'
		threshold1Display.GlyphTableIndexArray = 'None'
		threshold1Display.GaussianRadius = -1e+297
		threshold1Display.SetScaleArray = [None, '']
		threshold1Display.ScaleTransferFunction = 'PiecewiseFunction'
		threshold1Display.OpacityArray = [None, '']
		threshold1Display.OpacityTransferFunction = 'PiecewiseFunction'
		threshold1Display.DataAxesGrid = 'GridAxesRepresentation'
		threshold1Display.SelectionCellLabelFontFile = ''
		threshold1Display.SelectionPointLabelFontFile = ''
		threshold1Display.PolarAxes = 'PolarAxesRepresentation'

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		threshold1Display.DataAxesGrid.XTitleColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.XTitleFontFile = ''
		threshold1Display.DataAxesGrid.YTitleColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.YTitleFontFile = ''
		threshold1Display.DataAxesGrid.ZTitleColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.ZTitleFontFile = ''
		threshold1Display.DataAxesGrid.XLabelColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.XLabelFontFile = ''
		threshold1Display.DataAxesGrid.YLabelColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.YLabelFontFile = ''
		threshold1Display.DataAxesGrid.ZLabelColor = [0.0, 0.0, 0.0]
		threshold1Display.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		threshold1Display.PolarAxes.PolarAxisTitleColor = [0.0, 0.0, 0.0]
		threshold1Display.PolarAxes.PolarAxisTitleFontFile = ''
		threshold1Display.PolarAxes.PolarAxisLabelColor = [0.0, 0.0, 0.0]
		threshold1Display.PolarAxes.PolarAxisLabelFontFile = ''
		threshold1Display.PolarAxes.LastRadialAxisTextColor = [0.0, 0.0, 0.0]
		threshold1Display.PolarAxes.LastRadialAxisTextFontFile = ''
		threshold1Display.PolarAxes.SecondaryRadialAxesTextColor = [0.0, 0.0, 0.0]
		threshold1Display.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# update the view to ensure updated data information
		renderView1.Update()

		# Properties modified on threshold1
		threshold1.AllScalars = 0

		# update the view to ensure updated data information
		renderView1.Update()

		# Properties modified on threshold1Display
		threshold1Display.SetScaleArray = [None, 'Tiff Scalars']

		# Properties modified on threshold1Display
		threshold1Display.OpacityArray = [None, 'Tiff Scalars']

		# Properties modified on threshold1Display
		threshold1Display.OSPRayScaleArray = 'Tiff Scalars'

		# create a new 'TIFF Series Reader'

		testImageName = 'test-ef-image-dim-200-edim-5-seed-'+s+'-'+c+'.tif'
		binaryImage = TIFFSeriesReader(FileNames=[directory+'/test-images/'+testImageName+'.tif'])

		# show data in view
		binaryImageDisplay = Show(binaryImage, renderView1)

		# trace defaults for the display properties.
		binaryImageDisplay.Representation = 'Outline'
		binaryImageDisplay.ColorArrayName = ['POINTS', '']
		binaryImageDisplay.OSPRayScaleArray = 'Tiff Scalars'
		binaryImageDisplay.OSPRayScaleFunction = 'PiecewiseFunction'
		binaryImageDisplay.SelectOrientationVectors = 'None'
		binaryImageDisplay.ScaleFactor = 19.900000000000002
		binaryImageDisplay.SelectScaleArray = 'Tiff Scalars'
		binaryImageDisplay.GlyphType = 'Arrow'
		binaryImageDisplay.GlyphTableIndexArray = 'Tiff Scalars'
		binaryImageDisplay.GaussianRadius = 0.995
		binaryImageDisplay.SetScaleArray = ['POINTS', 'Tiff Scalars']
		binaryImageDisplay.ScaleTransferFunction = 'PiecewiseFunction'
		binaryImageDisplay.OpacityArray = ['POINTS', 'Tiff Scalars']
		binaryImageDisplay.OpacityTransferFunction = 'PiecewiseFunction'
		binaryImageDisplay.DataAxesGrid = 'GridAxesRepresentation'
		binaryImageDisplay.SelectionCellLabelFontFile = ''
		binaryImageDisplay.SelectionPointLabelFontFile = ''
		binaryImageDisplay.PolarAxes = 'PolarAxesRepresentation'
		binaryImageDisplay.ScalarOpacityUnitDistance = 1.7320508075688776
		binaryImageDisplay.IsosurfaceValues = [127.5]
		binaryImageDisplay.Slice = 99

		# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
		binaryImageDisplay.ScaleTransferFunction.Points = [0.0, 0.0, 0.5, 0.0, 255.0, 1.0, 0.5, 0.0]

		# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
		binaryImageDisplay.OpacityTransferFunction.Points = [0.0, 0.0, 0.5, 0.0, 255.0, 1.0, 0.5, 0.0]

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		binaryImageDisplay.DataAxesGrid.XTitleColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.XTitleFontFile = ''
		binaryImageDisplay.DataAxesGrid.YTitleColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.YTitleFontFile = ''
		binaryImageDisplay.DataAxesGrid.ZTitleColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.ZTitleFontFile = ''
		binaryImageDisplay.DataAxesGrid.XLabelColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.XLabelFontFile = ''
		binaryImageDisplay.DataAxesGrid.YLabelColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.YLabelFontFile = ''
		binaryImageDisplay.DataAxesGrid.ZLabelColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		binaryImageDisplay.PolarAxes.PolarAxisTitleColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.PolarAxes.PolarAxisTitleFontFile = ''
		binaryImageDisplay.PolarAxes.PolarAxisLabelColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.PolarAxes.PolarAxisLabelFontFile = ''
		binaryImageDisplay.PolarAxes.LastRadialAxisTextColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.PolarAxes.LastRadialAxisTextFontFile = ''
		binaryImageDisplay.PolarAxes.SecondaryRadialAxesTextColor = [0.0, 0.0, 0.0]
		binaryImageDisplay.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# update the view to ensure updated data information
		renderView1.Update()

		# create a new 'Threshold'
		threshold2 = Threshold(Input=binaryImage)
		threshold2.Scalars = ['POINTS', 'Tiff Scalars']
		threshold2.ThresholdRange = [0.0, 255.0]

		# Properties modified on threshold2
		threshold2.ThresholdRange = [1.0, 255.0]

		# show data in view
		threshold2Display = Show(threshold2, renderView1)

		# get color transfer function/color map for 'TiffScalars'
		tiffScalarsLUT = GetColorTransferFunction('TiffScalars')

		# get opacity transfer function/opacity map for 'TiffScalars'
		tiffScalarsPWF = GetOpacityTransferFunction('TiffScalars')

		# trace defaults for the display properties.
		threshold2Display.Representation = 'Surface'
		threshold2Display.ColorArrayName = ['POINTS', 'Tiff Scalars']
		threshold2Display.LookupTable = tiffScalarsLUT
		threshold2Display.OSPRayScaleArray = 'Tiff Scalars'
		threshold2Display.OSPRayScaleFunction = 'PiecewiseFunction'
		threshold2Display.SelectOrientationVectors = 'None'
		threshold2Display.ScaleFactor = 19.900000000000002
		threshold2Display.SelectScaleArray = 'Tiff Scalars'
		threshold2Display.GlyphType = 'Arrow'
		threshold2Display.GlyphTableIndexArray = 'Tiff Scalars'
		threshold2Display.GaussianRadius = 0.995
		threshold2Display.SetScaleArray = ['POINTS', 'Tiff Scalars']
		threshold2Display.ScaleTransferFunction = 'PiecewiseFunction'
		threshold2Display.OpacityArray = ['POINTS', 'Tiff Scalars']
		threshold2Display.OpacityTransferFunction = 'PiecewiseFunction'
		threshold2Display.DataAxesGrid = 'GridAxesRepresentation'
		threshold2Display.SelectionCellLabelFontFile = ''
		threshold2Display.SelectionPointLabelFontFile = ''
		threshold2Display.PolarAxes = 'PolarAxesRepresentation'
		threshold2Display.ScalarOpacityFunction = tiffScalarsPWF
		threshold2Display.ScalarOpacityUnitDistance = 2.7389787111726265

		# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
		threshold2Display.ScaleTransferFunction.Points = [255.0, 0.0, 0.5, 0.0, 255.03125, 1.0, 0.5, 0.0]

		# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
		threshold2Display.OpacityTransferFunction.Points = [255.0, 0.0, 0.5, 0.0, 255.03125, 1.0, 0.5, 0.0]

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

		# show color bar/color legend
		threshold2Display.SetScalarBarVisibility(renderView1, True)

		# update the view to ensure updated data information
		renderView1.Update()

		# Hide the scalar bar for this color map if no visible data is colored by it.
		HideScalarBarIfNotNeeded(tiffScalarsLUT, renderView1)

		# create a new 'Transform'
		transform1 = Transform(Input=threshold2)
		transform1.Transform = 'Transform'

		# Properties modified on transform1.Transform
		transform1.Transform.Scale = [0.001, 0.001, 0.001]

		# Properties modified on transform1.Transform
		transform1.Transform.Scale = [0.001, 0.001, 0.001]

		# show data in view
		transform1Display = Show(transform1, renderView1)

		# trace defaults for the display properties.
		transform1Display.Representation = 'Surface'
		transform1Display.ColorArrayName = [None, '']
		transform1Display.OSPRayScaleArray = 'Tiff Scalars'
		transform1Display.OSPRayScaleFunction = 'PiecewiseFunction'
		transform1Display.SelectOrientationVectors = 'None'
		transform1Display.ScaleFactor = 0.019900000095367434
		transform1Display.SelectScaleArray = 'None'
		transform1Display.GlyphType = 'Arrow'
		transform1Display.GlyphTableIndexArray = 'None'
		transform1Display.GaussianRadius = 0.0009950000047683717
		transform1Display.SetScaleArray = ['POINTS', 'Tiff Scalars']
		transform1Display.ScaleTransferFunction = 'PiecewiseFunction'
		transform1Display.OpacityArray = ['POINTS', 'Tiff Scalars']
		transform1Display.OpacityTransferFunction = 'PiecewiseFunction'
		transform1Display.DataAxesGrid = 'GridAxesRepresentation'
		transform1Display.SelectionCellLabelFontFile = ''
		transform1Display.SelectionPointLabelFontFile = ''
		transform1Display.PolarAxes = 'PolarAxesRepresentation'
		transform1Display.ScalarOpacityUnitDistance = 0.0027389787155090157

		# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
		transform1Display.ScaleTransferFunction.Points = [255.0, 0.0, 0.5, 0.0, 255.03125, 1.0, 0.5, 0.0]

		# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
		transform1Display.OpacityTransferFunction.Points = [255.0, 0.0, 0.5, 0.0, 255.03125, 1.0, 0.5, 0.0]

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		transform1Display.DataAxesGrid.XTitleColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.XTitleFontFile = ''
		transform1Display.DataAxesGrid.YTitleColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.YTitleFontFile = ''
		transform1Display.DataAxesGrid.ZTitleColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.ZTitleFontFile = ''
		transform1Display.DataAxesGrid.XLabelColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.XLabelFontFile = ''
		transform1Display.DataAxesGrid.YLabelColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.YLabelFontFile = ''
		transform1Display.DataAxesGrid.ZLabelColor = [0.0, 0.0, 0.0]
		transform1Display.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		transform1Display.PolarAxes.PolarAxisTitleColor = [0.0, 0.0, 0.0]
		transform1Display.PolarAxes.PolarAxisTitleFontFile = ''
		transform1Display.PolarAxes.PolarAxisLabelColor = [0.0, 0.0, 0.0]
		transform1Display.PolarAxes.PolarAxisLabelFontFile = ''
		transform1Display.PolarAxes.LastRadialAxisTextColor = [0.0, 0.0, 0.0]
		transform1Display.PolarAxes.LastRadialAxisTextFontFile = ''
		transform1Display.PolarAxes.SecondaryRadialAxesTextColor = [0.0, 0.0, 0.0]
		transform1Display.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# hide data in view
		Hide(threshold2, renderView1)

		# update the view to ensure updated data information
		renderView1.Update()

		# reset view to fit data bounds
		renderView1.ResetCamera(0.0, 0.197999998927, 0.0, 0.199000000954, 0.054999999702, 0.199000000954)

		# Properties modified on transform1Display
		transform1Display.Opacity = 0.33

		# Properties modified on transform1Display
		transform1Display.Opacity = 0.23

		# toggle 3D widget visibility (only when running from the GUI)
		Hide3DWidgets(proxy=transform1.Transform)

		# hide data in view
		Hide(binaryImage, renderView1)

		# hide data in view
		Hide(binaryImageruns1weighted1maxShift300vectors4ratio10seedstif, renderView1)
		# set active source
		SetActiveSource(threshold1)

		# reset view to fit data
		renderView1.ResetCamera()

		# save screenshot
		SaveScreenshot(directory+name+'-test-bla.png', renderView1, ImageResolution=[984, 961], 
		    # PNG options
		    CompressionLevel='0')

		Delete(threshold1)
		del threshold1
		Delete(threshold2)
		del threshold2

		# destroy testefimagedim200edim5seed7005tifruns6weighted1maxShift300vectors100ratio10EFtif
		Delete(binaryImage)
		del binaryImage
		Delete(image)
		del image
		
		# delete transform
		Delete(transform1)
		del transform1
