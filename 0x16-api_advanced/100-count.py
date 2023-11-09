#!/usr/bin/python3
"""queries the Reddit API and returns a list containing the titles
of all hot articles and prints a sorted count of given keywords."""

import re
import requests


def recurse(subreddit, hot_list=[], after=None):
    """Recurse finding hot articles of a subreddit."""
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
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


def count_words(subreddit, word_list):
    """prints sorted count of keywords."""
    hot_list = recurse(subreddit, [])
    if hot_list is None:
        hot_list = []
    if word_list is None:
        word_list = []
    results = {}
    for word in word_list:
        count = 0
        for title in hot_list:
            count += len(re.findall(r"\b{}\b".format(word), title, re.I))
        if results.get(word.lower()) is not None:
            results[word.lower()] += count
        results[word.lower()] = count

    results = sorted(
            results.items(), key=lambda item: (item[1], item[0]), reverse=True
            )
    for item in results:
        word = item[0]
        count = item[1]
        if count:
            print(word + ":", count)
