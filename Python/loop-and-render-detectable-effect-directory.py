# trace generated using paraview version 5.5.0-RC3-111-g1aabbaa

#
from os import listdir

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

directory = '/media/alessandro/CT Ext.HDD002/ale/detectable-effect-study-6-runs/EF/'

seeds =  ['23','29','31','7']
codes = ['500','050','005','550','505','055','555']

for s in seeds:
	for c in codes:
		name = 'test-ef-image-dim-200-edim-5-seed-'+s+'-'+c+'.tif-runs-6-weighted-1-maxShift-300-vectors-100-ratio-10-EF.tif'

		# create a new 'TIFF Series Reader'
		image = TIFFSeriesReader(FileNames=[directory+name])
		image.CustomDataSpacing = [0.001, 0.001, 0.001]

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
		imageDisplay.ScaleFactor = 0.0199
		imageDisplay.SelectScaleArray = 'Tiff Scalars'
		imageDisplay.GlyphType = 'Arrow'
		imageDisplay.GlyphTableIndexArray = 'Tiff Scalars'
		imageDisplay.GaussianRadius = 0.000995
		imageDisplay.SetScaleArray = ['POINTS', 'Tiff Scalars']
		imageDisplay.ScaleTransferFunction = 'PiecewiseFunction'
		imageDisplay.OpacityArray = ['POINTS', 'Tiff Scalars']
		imageDisplay.OpacityTransferFunction = 'PiecewiseFunction'
		imageDisplay.DataAxesGrid = 'GridAxesRepresentation'
		imageDisplay.SelectionCellLabelFontFile = ''
		imageDisplay.SelectionPointLabelFontFile = ''
		imageDisplay.PolarAxes = 'PolarAxesRepresentation'
		imageDisplay.ScalarOpacityUnitDistance = 0.001732050807568878
		imageDisplay.IsosurfaceValues = [-0.004328668117523193]
		imageDisplay.Slice = 99

		# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
		imageDisplay.ScaleTransferFunction.Points = [-0.9446412920951843, 0.0, 0.5, 0.0, 0.9359839558601379, 1.0, 0.5, 0.0]

		# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
		imageDisplay.OpacityTransferFunction.Points = [-0.9446412920951843, 0.0, 0.5, 0.0, 0.9359839558601379, 1.0, 0.5, 0.0]

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		imageDisplay.DataAxesGrid.XTitleFontFile = ''
		imageDisplay.DataAxesGrid.YTitleFontFile = ''
		imageDisplay.DataAxesGrid.ZTitleFontFile = ''
		imageDisplay.DataAxesGrid.XLabelFontFile = ''
		imageDisplay.DataAxesGrid.YLabelFontFile = ''
		imageDisplay.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		imageDisplay.PolarAxes.PolarAxisTitleFontFile = ''
		imageDisplay.PolarAxes.PolarAxisLabelFontFile = ''
		imageDisplay.PolarAxes.LastRadialAxisTextFontFile = ''
		imageDisplay.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# reset view to fit data
		renderView1.ResetCamera()

		# update the view to ensure updated data information
		renderView1.Update()

		# create a new 'Threshold'
		threshold1 = Threshold(Input=image)
		threshold1.Scalars = ['POINTS', 'Tiff Scalars']
		threshold1.ThresholdRange = [-0.9446412920951843, 0.9359839558601379]

		# show data in view
		threshold1Display = Show(threshold1, renderView1)

		# get color transfer function/color map for 'TiffScalars'
		tiffScalarsLUT = GetColorTransferFunction('TiffScalars')
		tiffScalarsLUT.RGBPoints = [-0.9446412920951843, 0.231373, 0.298039, 0.752941, -0.004328668117523193, 0.865003, 0.865003, 0.865003, 0.9359839558601379, 0.705882, 0.0156863, 0.14902]
		tiffScalarsLUT.ScalarRangeInitialized = 1.0

		# get opacity transfer function/opacity map for 'TiffScalars'
		tiffScalarsPWF = GetOpacityTransferFunction('TiffScalars')
		tiffScalarsPWF.Points = [-0.9446412920951843, 0.0, 0.5, 0.0, 0.9359839558601379, 1.0, 0.5, 0.0]
		tiffScalarsPWF.ScalarRangeInitialized = 1

		# trace defaults for the display properties.
		threshold1Display.Representation = 'Surface'
		threshold1Display.ColorArrayName = ['POINTS', 'Tiff Scalars']
		threshold1Display.LookupTable = tiffScalarsLUT
		threshold1Display.OSPRayScaleArray = 'Tiff Scalars'
		threshold1Display.OSPRayScaleFunction = 'PiecewiseFunction'
		threshold1Display.SelectOrientationVectors = 'None'
		threshold1Display.ScaleFactor = 0.019900000095367434
		threshold1Display.SelectScaleArray = 'Tiff Scalars'
		threshold1Display.GlyphType = 'Arrow'
		threshold1Display.GlyphTableIndexArray = 'Tiff Scalars'
		threshold1Display.GaussianRadius = 0.0009950000047683717
		threshold1Display.SetScaleArray = ['POINTS', 'Tiff Scalars']
		threshold1Display.ScaleTransferFunction = 'PiecewiseFunction'
		threshold1Display.OpacityArray = ['POINTS', 'Tiff Scalars']
		threshold1Display.OpacityTransferFunction = 'PiecewiseFunction'
		threshold1Display.DataAxesGrid = 'GridAxesRepresentation'
		threshold1Display.SelectionCellLabelFontFile = ''
		threshold1Display.SelectionPointLabelFontFile = ''
		threshold1Display.PolarAxes = 'PolarAxesRepresentation'
		threshold1Display.ScalarOpacityFunction = tiffScalarsPWF
		threshold1Display.ScalarOpacityUnitDistance = 0.0034637475545047014

		# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
		threshold1Display.ScaleTransferFunction.Points = [-0.9446412920951843, 0.0, 0.5, 0.0, 0.9359839558601379, 1.0, 0.5, 0.0]

		# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
		threshold1Display.OpacityTransferFunction.Points = [-0.9446412920951843, 0.0, 0.5, 0.0, 0.9359839558601379, 1.0, 0.5, 0.0]

		# init the 'GridAxesRepresentation' selected for 'DataAxesGrid'
		threshold1Display.DataAxesGrid.XTitleFontFile = ''
		threshold1Display.DataAxesGrid.YTitleFontFile = ''
		threshold1Display.DataAxesGrid.ZTitleFontFile = ''
		threshold1Display.DataAxesGrid.XLabelFontFile = ''
		threshold1Display.DataAxesGrid.YLabelFontFile = ''
		threshold1Display.DataAxesGrid.ZLabelFontFile = ''

		# init the 'PolarAxesRepresentation' selected for 'PolarAxes'
		threshold1Display.PolarAxes.PolarAxisTitleFontFile = ''
		threshold1Display.PolarAxes.PolarAxisLabelFontFile = ''
		threshold1Display.PolarAxes.LastRadialAxisTextFontFile = ''
		threshold1Display.PolarAxes.SecondaryRadialAxesTextFontFile = ''

		# show color bar/color legend
		threshold1Display.SetScalarBarVisibility(renderView1, True)

		# update the view to ensure updated data information
		renderView1.Update()

		# Rescale transfer function
		tiffScalarsLUT.RescaleTransferFunction(-1.0, 1.0)

		# Rescale transfer function
		tiffScalarsPWF.RescaleTransferFunction(-1.0, 1.0)

		# Apply a preset using its name. Note this may not work as expected when presets have duplicate names.
		tiffScalarsLUT.ApplyPreset('Preset 0', True)

		# Apply a preset using its name. Note this may not work as expected when presets have duplicate names.
		tiffScalarsPWF.ApplyPreset('Preset 0', True)

		# hide data in view
		Hide(image, renderView1)

		# reset view to fit data
		renderView1.ResetCamera()

		# reset view to fit data
		renderView1.ResetCamera()

		# reset view to fit data
		renderView1.ResetCamera()

		# reset view to fit data
		renderView1.ResetCamera()

		# set active source
		SetActiveSource(image)

		# show data in view
		imageDisplay = Show(image, renderView1)

		# change solid color
		imageDisplay.AmbientColor = [0.0, 0.0, 0.0]

		# set active source
		SetActiveSource(threshold1)

		# get color legend/bar for tiffScalarsLUT in view renderView1
		tiffScalarsLUTColorBar = GetScalarBar(tiffScalarsLUT, renderView1)
		tiffScalarsLUTColorBar.Title = 'Tiff Scalars'
		tiffScalarsLUTColorBar.ComponentTitle = ''
		tiffScalarsLUTColorBar.TitleColor = [0.0, 0.0, 0.0]
		tiffScalarsLUTColorBar.TitleFontFile = ''
		tiffScalarsLUTColorBar.LabelColor = [0.0, 0.0, 0.0]
		tiffScalarsLUTColorBar.LabelFontFile = ''

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.Title = 'Ellipsoid Factor'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.DrawAnnotations = 0

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.AutomaticLabelFormat = 0

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.LabelFormat = '%-#6g'
		tiffScalarsLUTColorBar.RangeLabelFormat = '%-#6g'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.LabelFormat = '%-#2g'
		tiffScalarsLUTColorBar.RangeLabelFormat = '%-#2g'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.LabelFormat = '%-#2.0g'
		tiffScalarsLUTColorBar.RangeLabelFormat = '%-#2.0g'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.RangeLabelFormat = '%-#2.1g'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.UseCustomLabels = 1
		tiffScalarsLUTColorBar.CustomLabels = [0.0, 0.0]
		tiffScalarsLUTColorBar.AddRangeLabels = 0

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.CustomLabels = [0.0, 0.0, 0.0]

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.AutomaticLabelFormat = 1
		tiffScalarsLUTColorBar.CustomLabels = [0.0]

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.AddRangeLabels = 1

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.RangeLabelFormat = '%-#2.0g'

		# Properties modified on tiffScalarsLUTColorBar
		tiffScalarsLUTColorBar.UseCustomLabels = 0

		# current camera placement for renderView1
		renderView1.CameraPosition = [0.2968417623459954, 0.4319514113664366, 0.6430093441888992]
		renderView1.CameraFocalPoint = [0.06335147261276473, 0.10753971366779087, 0.11045120526148397]
		renderView1.CameraViewUp = [0.9360751929999802, -0.20819038897476563, -0.28358419382713435]
		renderView1.CameraParallelScale = 0.17233905617900946

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

		# destroy testefimagedim200edim5seed7005tifruns6weighted1maxShift300vectors100ratio10EFtif
		Delete(image)
		del image
