# @OpService ops
# @UIService ui
# @ImgPlus source

from net.imagej.ops import Ops
from net.imagej.ops.image.distancetransform import DistanceTransform3D
from net.imagej import ImgPlus

sourceBitType = ops.convert().bit(source)
d = ops.image().distancetransform(sourceBitType)
print(d)
distanceTransformedPlus = ImgPlus(d,source,True)
print("almost done")
ui.show("EDT",distanceTransformedPlus)