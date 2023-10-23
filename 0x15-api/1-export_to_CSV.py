#!/usr/bin/python3
"""Using a rest api, for a given employee id,
returns information about his/her todo list progress
and export data in the CSV format."""

import csv
import requests
from sys import argv


if __name__ == "__main__":
    USER_ID = argv[1]
    USERNAME = requests.get(
        f"https://jsonplaceholder.typicode.com/users/{USER_ID}"
    ).json()["username"]

    user_todos = requests.get(
        f"https://jsonplaceholder.typicode.com/user/{USER_ID}/todos"
    )
    with open(
        f"{USER_ID}.csv",
        "w",
    ) as csvFile:
        writer = csv.writer(csvFile, quoting=csv.QUOTE_ALL)
        [
            writer.writerow([USER_ID, USERNAME, i["completed"], i["title"]])
            for i in user_todos.json()
        ]
