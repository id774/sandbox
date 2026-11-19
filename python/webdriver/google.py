# google.py: Drive Internet Explorer with Selenium WebDriver
#
# Description:
# Open Google in Internet Explorer through Selenium WebDriver and
# IEDriverServer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python google.py
#
# Requirements:
# - Python 3
# - Selenium
# - Windows with Internet Explorer and C:\shared\IEDriverServer.exe
#

# WebDriver
from selenium import webdriver
# Read the information of an HTML tab
from selenium.webdriver.common.by import By
# Send keystrokes to the web browser
from selenium.webdriver.common.keys import Keys
# Check the state of the page opened by the next click
from selenium.webdriver.support import expected_conditions as EC
# Set the wait time
from selenium.webdriver.support.ui import WebDriverWait
# Control the confirmation dialog
from selenium.webdriver.common.alert import Alert

import time

# Set up the IE driver
browser = webdriver.Ie(r"C:\shared\IEDriverServer.exe")

# Fetch the page
browser.get('https://google.com')

# Maximize the browser
browser.maximize_window()
time.sleep(1)

# Search
element = browser.find_element_by_name("q")
element.send_keys("テスト")
time.sleep(1)

submitButton = browser.find_element_by_name("btnK")
submitButton.click()

# Close the browser
time.sleep(3)
browser.close()

