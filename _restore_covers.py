from PIL import Image, ImageDraw
import numpy as np
import shutil
import os

folder = r"D:\C+project\QtInstrumentCluster\images\albums"

# 用原始专辑图临时恢复（ak.png -> cover1.png, juno.png -> cover2.png, etc）
originals = ["ak.png", "juno.png", "phazz.png", "thievery-corp.png", "tycho.png"]

for i, orig in enumerate(originals, 1):
    src = os.path.join(folder, orig)
    dst = os.path.join(folder, f"cover{i}.png")
    
    img = Image.open(src).convert('RGBA')
    img = img.resize((144, 144), Image.LANCZOS)
    arr = np.array(img)
    h, w = arr.shape[:2]
    
    mask = Image.new('L', (w, h), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle([(0, 0), (w-1, h-1)], radius=3, fill=255)
    
    mask_arr = np.array(mask)
    arr[:,:,3] = 0
    arr[mask_arr == 255, 3] = 255
    
    Image.fromarray(arr).save(dst)
    print(f"cover{i}.png restored from {orig}")

print("Done - you can replace with original images later")