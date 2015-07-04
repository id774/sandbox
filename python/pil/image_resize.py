from PIL import Image
 
img = Image.open('1.jpg', 'r')
resize_img = img.resize((100, 100))
resize_img.save('2.jpg', 'JPEG', quality=100, optimize=True)
