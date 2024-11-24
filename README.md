# StretchyImage
This project demonstrates the implementation of a dynamic, stretchable image at the top of the screen, paired with a scrollable content area below it in a Swift-based application.


https://github.com/user-attachments/assets/a7391d9e-2788-47f3-b3b5-82c300f614db


## Overview

The main objective of this project is to create a layout where the image at the top of the screen interacts dynamically with the scrollable content area below it:

- **Image Height**: The image starts with a height of 270pt.
- **Downward Scroll**: When the user scrolls downward, the image stretches vertically while its top edge remains fixed to the top of the screen.
- **Upward Scroll**: When the user scrolls upward, the image moves upward and out of view along with the scroll.
- **Scroll Indicator Behavior**: The vertical scroll indicator always starts below the image and never overlaps it.
