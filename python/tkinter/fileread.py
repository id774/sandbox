# Pick a file with a Tkinter dialog and print its contents.

import tkinter as tk
from tkinter import filedialog

def open_file():
    # Pick a file with the dialog and put its path in the text box
    file_path = filedialog.askopenfilename()
    entry_file_path.delete(0, tk.END)
    entry_file_path.insert(0, file_path)

def read_file():
    # Take the path from the text box and read that file
    file_path = entry_file_path.get()
    if file_path:
        with open(file_path, 'r') as file:
            content = file.read()
        print(content)

def main():
    # Set up the GUI
    root = tk.Tk()
    root.geometry('500x100')

    # Create the frame and lay out the widgets
    frame = tk.Frame(root)
    frame.pack(pady=10)

    # Configure the text box
    global entry_file_path
    entry_file_path = tk.Entry(frame, width=50)
    entry_file_path.pack(side=tk.LEFT)

    # Configure the open button
    button_open = tk.Button(frame, text='開く', command=open_file)
    button_open.pack(side=tk.LEFT, padx=5)

    # Configure the read button
    button_read = tk.Button(frame, text='読み込み', command=read_file)
    button_read.pack(side=tk.LEFT)

    root.mainloop()

if __name__ == '__main__':
    main()

