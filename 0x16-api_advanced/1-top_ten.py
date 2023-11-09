#!/usr/bin/python3
"""queries the Reddit API and prints the titles
of the first 10 hot posts listed for a given subreddit.."""

import requests


def top_ten(subreddit):
    """Top ten tiles."""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "MyUserAgent"}

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code != 200:
            print(None)

        if response.status_code == 200:
            top_ten = [
                    (child["data"]["name"],
                        child["data"]["title"],
                        child["data"]["ups"])
                    for child in response.json()["data"]["children"]
                    ][:10]  # ,
            # key=lambda x: x[2],
            # reverse=True,
            #  )[:10]
            if top_ten:
                [print(post[1]) for post in top_ten]
            else:
                print(None)

    except requests.exceptions.RequestException as e:
        print(None)
