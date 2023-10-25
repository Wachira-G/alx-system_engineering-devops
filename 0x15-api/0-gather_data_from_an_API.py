#!/usr/bin/python3
"""Using a rest api, for a given employee id,
returns information about his/her todo list progress"""

import requests
from sys import argv

if __name__ == "__main__":
    NAM = requests.get(
        f"https://jsonplaceholder.typicode.com/users/{argv[1]}").json()["name"]

    user_tasks = requests.get(
        f"https://jsonplaceholder.typicode.com/user/{argv[1]}/todos"
    )
    completed_todos = [i for i in user_tasks.json() if i["completed"] is True]

    DONE_TASKS = len(completed_todos)
    TOTAL_TASKS = len(user_tasks.json())

    print(f"Employee {NAM} is done with tasks({DONE_TASKS}/{TOTAL_TASKS}):")
    for todo in completed_todos:
        TASK_TITLE = todo["title"]
        print(f"\t{TASK_TITLE}")
