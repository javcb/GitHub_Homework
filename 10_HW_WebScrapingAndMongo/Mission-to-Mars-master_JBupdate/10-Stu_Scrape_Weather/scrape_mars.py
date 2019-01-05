from splinter import Browser
from bs4 import BeautifulSoup as bs
import time


def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {"executable_path": "chromedriver"}
    return Browser("chrome", **executable_path, headless=False)


def scrape_info():
    browser = init_browser()

    # Visit visitcostarica.herokuapp.com
    url = "https://mars.nasa.gov/news/"
    browser.visit(url)

    time.sleep(1)

    # Scrape page into Soup
    html = browser.html
    soup = bs(html, "html.parser")

# retrieve elements
    min_temp = soup.find("div",class_="content_title").text
    max_temp = soup.find("div", class_="article_teaser_body").text

    # # Get the average temps
    # avg_temps = soup.find('div', id='weather')

    # # Get the min avg temp
    # min_temp = avg_temps.find_all('strong')[0].text

    # # Get the max avg temp
    # max_temp = avg_temps.find_all('strong')[1].text

    # # BONUS: Find the src for the sloth image
    # relative_image_path = soup.find_all('img')[2]["src"]
    # sloth_img = url + relative_image_path
    featured_image_url = 'https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA16225_hires.jpg'
    sloth_img = featured_image_url

    # Twitter scrape
    twitter_url = "https://twitter.com/marswxreport?lang=en"
    browser.visit(twitter_url)
    time.sleep(1)

    html = browser.html
    soup = bs(html, "html.parser")

    marstweet_temp = soup.find('p', class_="TweetTextSize TweetTextSize--normal js-tweet-text tweet-text").text
    print(marstweet_temp)

    # Store data in a dictionary
    mars_data = {
        "sloth_img": sloth_img,
        "min_temp": min_temp,
        "max_temp": max_temp,
        "marstweet_temp": marstweet_temp
    }

    # Close the browser after scraping
    browser.quit()

    # Return results #
    return mars_data
