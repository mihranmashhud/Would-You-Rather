import requests

BASE = "http://localhost:5000/query_recipes"

response = requests.get(BASE, {'username': 'Mrgank', 'type': 'main course'})
print(response.json())

