from PIL import Image
import os

folder = r"D:\C+project\QtInstrumentCluster\images\albums"
for f in ["cover1.png","cover2.png","cover3.png","cover4.png","cover5.png"]:
    path = os.path.join(folder, f)
    if os.path.exists(path):
        img = Image.open(path)
        print(f"{f}: {img.size}")

# Also check navigation/phone content images
folder2 = r"D:\C+project\QtInstrumentCluster\images\menu"
for f in ["navigation.png", "phone-call.png"]:
    path = os.path.join(folder2, f)
    if os.path.exists(path):
        img = Image.open(path)
        print(f"{f}: {img.size}")