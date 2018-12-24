import requests
import bs4
from bs4 import BeautifulSoup

search = input("Enter search term:")
params = {"q": search}
r = requests.get("https://www.bing.com/search", params=params)

soup = BeautifulSoup()