# Iterate two lists in parallel with zip.

names = ['Taro', 'Hanako', 'Jiro']
colors = ['blue', 'red', 'yellow']

for name, color in zip(names, colors):
    print(name, '-->', color)
