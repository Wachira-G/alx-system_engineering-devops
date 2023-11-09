#!/usr/bin/python3
"""queries the Reddit API and returns a list containing the titles
of all hot articles for a given subreddit.."""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """Recurse finding hot articles of a subreddit."""
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "MyUserAgent"}
    params = {"after": after}

    try:
        response = requests.get(
            url, headers=headers, params=params, allow_redirects=False
        )

        if response.status_code != 200:
            return None

        data = response.json()["data"]
        hot_list += [post["data"]["title"] for post in data["children"]]
        after = data["after"]

        if after is None:
            return hot_list

        return recurse(subreddit, hot_list, after)

    except requests.exceptions.RequestException as e:
        return hot_list
