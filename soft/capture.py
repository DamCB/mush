# High-Definition video camera for Raspberry Pi Model A/B/B+ and Raspberry Pi 2
# 5MPixel sensor with Omnivision OV5647 sensor in a fixed-focus lens
# Integral IR filter
# Angle of View: 54 x 41 degrees
# Field of View: 2.0 x 1.33 m at 2 m
# Full-frame SLR lens equivalent: 35 mm
# Fixed Focus: 1 m to infinity
# Still picture resolution: 2592 x 1944
# Max video resolution: 1080p
# Max frame rate: 30fps
# Size: 300 x 16 mm flex cable, neck wide is 6mm

# https://github.com/pimoroni/python-multitouch/blob/master/examples/hyperpixel4/ui.py


"""
Addapted from kivy Camera example

"""


from kivy.app import App
from kivy.lang import Builder
from kivy.uix.boxlayout import BoxLayout
import time

Builder.load_string(
    """
<CameraClick>:
    orientation: 'vertical'
    Camera:
        id: camera
        resolution: (800, 480)
        play: False
    ToggleButton:
        text: 'Play'
        on_press: camera.play = not camera.play
        size_hint_y: None
        height: '40dp'
    Button:
        text: 'Capture'
        size_hint_y: None
        height: '40dp'
        on_press: root.capture()
"""
)


class CameraClick(BoxLayout):
    def capture(self):
        """
        Function to capture the images and give them the names
        according to their captured time and date.
        """
        camera = self.ids["camera"]
        timestr = time.strftime("%Y%m%d_%H%M%S")
        camera.export_to_png("IMG_{}.png".format(timestr))
        print("Captured")


class TestCamera(App):
    def build(self):
        return CameraClick()


TestCamera().run()
