#!/usr/bin/python3
"""export data to json format"""

import json
import requests


if __name__ == "__main__":

    users = requests.get(f"https://jsonplaceholder.typicode.com/users").json()
    todos = requests.get(f"https://jsonplaceholder.typicode.com/todos").json()
    full_data = {}
    for user in users:
        user_id = user["id"]
        username = user["username"]
        user_todos = [todo for todo in todos if todo["userId"] == user_id]
        dicti = {
            user_id: [
                {
                    "task": task["title"],
                    "completed": task["completed"],
                    "username": username,
                }
                for task in todos
            ]
        }
        full_data.update(dicti)

    with open("todo_all_employees.json", "w") as file:
        json.dump(full_data, file)
