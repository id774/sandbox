import tkinter as tk
from tkinter import filedialog

def open_file():
    # ファイルダイアログでファイルを選択し、テキストボックスにパスを挿入
    file_path = filedialog.askopenfilename()
    entry_file_path.delete(0, tk.END)
    entry_file_path.insert(0, file_path)

def read_file():
    # テキストボックスからファイルパスを取得し、そのファイルを読み込む
    file_path = entry_file_path.get()
    if file_path:
        with open(file_path, 'r') as file:
            content = file.read()
        print(content)

def main():
    # GUIの初期設定
    root = tk.Tk()
    root.geometry('500x100')

    # フレームを作成し、ウィジェットを配置
    frame = tk.Frame(root)
    frame.pack(pady=10)

    # テキストボックスの設定
    global entry_file_path
    entry_file_path = tk.Entry(frame, width=50)
    entry_file_path.pack(side=tk.LEFT)

    # 開くボタンの設定
    button_open = tk.Button(frame, text='開く', command=open_file)
    button_open.pack(side=tk.LEFT, padx=5)

    # 読み込みボタンの設定
    button_read = tk.Button(frame, text='読み込み', command=read_file)
    button_read.pack(side=tk.LEFT)

    root.mainloop()

if __name__ == '__main__':
    main()

