from PIL import Image
import numpy as np
import os

folder = r"D:\C+project\QtInstrumentCluster\images\albums"
new_files = ["半岛铁盒.png", "大笨钟.png", "美人鱼.png", "我不配.png", "园游会.png"]

for f in new_files:
    path = os.path.join(folder, f)
    if os.path.exists(path):
        img = Image.open(path).convert('RGBA')
        arr = np.array(img)
        # 检查是否有非透明像素
        opaque = np.sum(arr[:,:,3] > 0)
        total = arr.shape[0] * arr.shape[1]
        # 检查四个角的透明度
        corners = f"TL={arr[0,0,3]}, TR={arr[0,-1,3]}, BL={arr[-1,0,3]}, BR={arr[-1,-1,3]}"
        print(f"{f}: {img.size}, mode={img.mode}, opaque={opaque}/{total}, corners=[{corners}]")
    else:
        print(f"{f}: NOT FOUND")