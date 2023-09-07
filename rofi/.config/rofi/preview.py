
import os


for t in range (7):
    folder = f'./launchers/type-{t+1}/'
    for filename in os.listdir(folder):
        if "rasi" in filename:
            print(folder,filename)
            command = f"""
rofi \
    -show drun \
    -theme {folder}{filename}
            """
            os.system(command) 

