#!/usr/bin/python3
"""queries the Reddit API and returns the number of subscribers
(not active users, total subscribers) for a given subreddit."""

import json
import requests


def number_of_subscribers(subreddit):
    """Query no of subscribers."""
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {"User-Agent": "MyUserAgent"}

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code != 200:
            return 0

        subscribers = json.loads(response.text)["data"]["subscribers"]
        if subscribers:
            return subscribers
        return 0

    except requests.exceptions.RequestException as e:
        return 0
