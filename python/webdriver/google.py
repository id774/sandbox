# WebDriver
from selenium import webdriver
# HTML の タブの情報を取得
from selenium.webdriver.common.by import By
# キーボードを叩いた時に Web ブラウザに情報を送信する
from selenium.webdriver.common.keys import Keys
# 次にクリックしたページがどんな状態になっているかチェックする
from selenium.webdriver.support import expected_conditions as EC
# 待機時間を設定
from selenium.webdriver.support.ui import WebDriverWait
# 確認ダイアログ制御
from selenium.webdriver.common.alert import Alert

import time

# IE ドライバのセットアップ
browser = webdriver.Ie(r"C:\shared\IEDriverServer.exe")

# Web 情報を取得
browser.get('https://google.com')

# ブラウザ最大化
browser.maximize_window()
time.sleep(1)

# 検索
element = browser.find_element_by_name("q")
element.send_keys("テスト")
time.sleep(1)

submitButton = browser.find_element_by_name("btnK")
submitButton.click()

# ブラウザを閉じる
time.sleep(3)
browser.close()

