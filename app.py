from flask import Flask, request, abort, jsonify
from requests.api import delete
from werkzeug.wrappers import Response
from flask_restful import Api, Resource, reqparse
import psycopg2
import requests
import json

app = Flask(__name__)
api = Api(app)

DB_CONNECTION_STRING = "postgresql://alaap:Alaapguoft123!@free-tier.gcp-us-central1.cockroachlabs.cloud:26257/app_database?sslmode=verify-full&sslrootcert=root.crt&options=--cluster%3Dwould-you-rather-3535"
TENANT_NAME = "foodwisehtn"
TENANT_ID = "b00c4a3e-4486-468a-bde1-41ef41d22211"
B2C_POLICY = "B2C_1_signupsignin"
CLIENT_ID = "08ddf53c-e981-4501-84af-bded544e207b"
KEY="ea92b49964mshdd05427798b593dp1dc646jsn74855f369429"

preferences_put_args = reqparse.RequestParser()
preferences_put_args.add_argument("username", type=str, help="The name of the user is required", required=True)
preferences_put_args.add_argument("diet_type", type=str, help="The dietary restrictions of the user are required")
preferences_put_args.add_argument("max_time", type=int, help="The maximum prep time value is required")
preferences_put_args.add_argument("restrictions", type=str, help="The dietary intolerances of the user are required")

preferences_delete_args = reqparse.RequestParser()
preferences_delete_args.add_argument("username", type=str, help="The name of the user is required", required=True)

recipe_by_id_args = reqparse.RequestParser()
recipe_by_id_args.add_argument("recipe_id", type=str, help="The ID of the recipe is required", required=True)

favourites_get_args = reqparse.RequestParser()
favourites_get_args.add_argument("username", type=str, help="The name of the user is required", required=True)

query_recipes_args = reqparse.RequestParser()
query_recipes_args.add_argument("type", type=str, help="The type of meal to search for is required", required=True)
query_recipes_args.add_argument("query", type=str, help="The type of food to search for is required")
query_recipes_args.add_argument("cuisine", type=str, help="The type of cuisine to search for is required")
query_recipes_args.add_argument("username", type=str, help="The username is required", required=True)

query_random_args = reqparse.RequestParser()
query_random_args.add_argument("tags", type=str, help="The tags related to the type of food you want are required")

favourites_put_args = reqparse.RequestParser()
favourites_put_args.add_argument("username", type=str, help="The name of the user is required", required=True)
favourites_put_args.add_argument("recipe_id", type=int, help="The identification number of the recipe is required", required=True)
favourites_put_args.add_argument("rating", type=int, help="The rating the user gave the recipe is required", required=True)

favourites_patch_args = reqparse.RequestParser()
favourites_patch_args.add_argument("username", type=str, help="The name of the user is required", required=True)
favourites_patch_args.add_argument("recipe_id", type=int, help="The identification number of the recipe is required", required=True)
favourites_patch_args.add_argument("rating", type=int, help="The rating the user gave the recipe is required", required=True)

class Preferences(Resource):
    def get(self):
        args = preferences_delete_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        result = ""
        with conn.cursor() as curr:
            curr.execute(f"SELECT * from favourites WHERE username = \'{args['username']}\' LIMIT 1")
            result = curr.fetchall()
            conn.commit()
        conn.close()
        return result

    def put(self):
        args = preferences_put_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        StringDB = f"INSERT INTO preferences (username, diet_type, max_time, restrictions) VALUES (\'{args['username']}\'"
        for arg in args:
            if (arg != 'username'):
                if (args[arg]):
                    StringDB += f", \'{args[arg]}\'"
                else:
                    StringDB += ", NULL"
        StringDB += ")"
        with conn.cursor() as curr:
            curr.execute(f"SELECT COUNT(*) FROM preferences WHERE username = \'{args['username']}\'")
            result = curr.fetchall()
            if (result[0][0] == 0):
                curr.execute(StringDB)
            conn.commit()
        conn.close()
        return 200

    def patch(self):
        args = preferences_put_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        StringDB = f"UPDATE preferences SET "
        STRING1 = "("
        STRING2 = "("
        for arg in args:
            if (arg != 'username'):
                if (args[arg]):
                    STRING1 += arg +", "
                    STRING2 += f"\'{args[arg]}\', "
        STRING1 = STRING1[:-2] + ")"
        STRING2 = STRING2[:-2] + ")"
        StringDB = StringDB + STRING1 + " = " + STRING2 + " "
        StringDB += f"WHERE username = \'{args['username']}\'"
        with conn.cursor() as curr:
            curr.execute(StringDB)
            conn.commit()
        conn.close()
        return 200

    def delete(self):
        delete_name = request.headers.get("username")
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        with conn.cursor() as curr:
            curr.execute(f"DELETE FROM preferences WHERE username = \'{delete_name}\'")
            conn.commit()
        conn.close()
        return 200
        

class query_recipes(Resource):
    def get(self):
        args = query_recipes_args.parse_args()
        url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?number=50&sort=popularity&sortDirection=desc"
        for arg in args:
            if args[arg] and arg != 'username':
                url += f"&{arg}={args[arg]}"
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        result = ""
        preference_types = ['diet', 'maxReadyTime', 'intolerances']
        with conn.cursor() as curr:
            curr.execute(f"SELECT * from preferences WHERE username = \'{args['username']}\' LIMIT 1")
            result = curr.fetchall()
            conn.commit()
        conn.close()
        for i in range(3):
            url += f"&{preference_types[i]}={result[0][i+1]}"      
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY})
        data = response.json()
        querystring = {"ids": ""}
        querystr = ""
        for i in range(10):
            try:
                querystr += str(data['results'][i-1]['id']) + ","
            except:
                break
        querystr = querystr[:-1]
        querystring = {"ids": querystr}
        querystring = json.dumps(querystring)
        url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/informationBulk"
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY}, params={"ids": querystr})
        return response.json()

class Favourites(Resource):
    def get(self):
        args = favourites_get_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        result = ""
        with conn.cursor() as curr:
            curr.execute(f"SELECT * from favourites WHERE username = \'{args['username']}\' LIMIT 10")
            result = curr.fetchall()
            conn.commit()
        conn.close()
        return result

    def put(self):
        args = favourites_put_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        with conn.cursor() as curr:
            curr.execute(f"SELECT COUNT(*) FROM favourites WHERE username = \'{args['username']}\' AND recipe_id = \'{args['recipe_id']}\'")
            result = curr.fetchall()
            if (result[0][0] == 0):
                curr.execute(f"INSERT INTO favourites (username, recipe_id, rating)\nVALUES (\'{args['username']}\', \'{args['recipe_id']}\', {args['rating']})")
                curr.execute(f"SELECT COUNT(*) FROM favourites WHERE username = \'{args['username']}\'")
                result = curr.fetchall()
                if (result[0][0] > 10):
                    curr.execute(f"DELETE FROM favourites WHERE id IN (SELECT id FROM favourites WHERE username = \'{args['username']}\' ORDER BY id ASC LIMIT 1)")
            conn.commit()
        conn.close()
        return 

    def patch(self):
        args = favourites_patch_args.parse_args()
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        with conn.cursor() as curr:
            curr.execute(f"UPDATE favourites SET rating = \'{args['rating']}\' WHERE username = \'{args['username']}\' AND recipe_id = \'{args['recipe_id']}\'")
            conn.commit()
        conn.close()
        return 200

    def delete(self):
        delete_name = request.headers.get("username")
        delete_id = request.headers.get("request_id")
        conn = psycopg2.connect(DB_CONNECTION_STRING)
        with conn.cursor() as curr:
            curr.execute(f"DELETE FROM favourites WHERE username = \'{delete_name}\' AND recipe_id = \'{delete_id}\'")
            conn.commit()
        conn.close()
        return 200

class query_random(Resource):
    def get(self):
        args = query_random_args.parse_args()
        url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=10&"
        if (args['tags']):
            url += f"tags = {args['tags']}"
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY})
        return response.json()

class query_by_id(Resource):
    def get(self):
        args = recipe_by_id_args.parse_args()
        url = f"https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/479101/information?id={args['recipe_id']}"
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY})
        return response
        

api.add_resource(Preferences, "/preferences")
api.add_resource(query_recipes, "/query_recipes")
api.add_resource(Favourites, "/favourites")
api.add_resource(query_random, "/query_random")
api.add_resource(query_by_id, "/query_id")

if __name__ == "__main__":
    app.run(debug=True)