import os

defaultPath = os.path.dirname(os.path.abspath(__file__))
dir_list = os.listdir(defaultPath)

dir_list = [f'      - assets/exercises/{fileOrDir.removesuffix(".json")}/' for fileOrDir in dir_list if fileOrDir.endswith('.json')]

print("\n")
print("\n")
print("\n")
print("\n")

for dir in dir_list:
    print(dir)