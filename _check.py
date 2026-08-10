from PIL import Image
import os

path = r"D:\C+project\QtInstrumentCluster\images\navigation.png"
img = Image.open(path)
print(f"Size: {img.size}")
print(f"Mode: {img.mode}")
print(f"File size: {os.path.getsize(path)} bytes")