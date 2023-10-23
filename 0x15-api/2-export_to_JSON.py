#!/usr/bin/python3
"""export data to json format"""

import json
import requests
from sys import argv


if __name__ == "__main__":

    user_id = argv[1]

    username = requests.get(
        f"https://jsonplaceholder.typicode.com/users/{user_id}"
    ).json()["username"]

    todos = requests.get(
        f"https://jsonplaceholder.typicode.com/users/{user_id}/todos"
    ).json()

    dicti = {
        user_id: [
            {"task": task["title"],
             "complete": task["completed"],
             "username": username}
            for task in todos
        ]
    }

    with open("{}.json".format(user_id), "w") as file:
        json.dump(dicti, file)
