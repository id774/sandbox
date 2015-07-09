from PIL import Image

a_jpg = Image.open('a.jpg', 'r')
b_jpg = Image.open('b.jpg', 'r')

canvas = Image.new('RGB', (100, 200), (255, 255, 255))

canvas.paste(a_jpg, (0, 0))
canvas.paste(b_jpg, (0, 100))

canvas.save('c.jpg', 'JPEG', quality=100, optimize=True)
