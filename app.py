from flask import Flask, request, abort, jsonify, _request_ctx_stack
from requests.api import delete
from werkzeug.wrappers import Response
from flask_restful import Api, Resource, reqparse
import psycopg2
import requests
import json
from functools import wraps
from six.moves.urllib.request import urlopen
from jose import jwt

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

class AuthError(Exception):
    def __init__(self, error, status_code):
        self.error = error
        self.status_code = status_code

def get_token_auth_header():
    authenticate = request.headers.get("Authorization", None)
    if not authenticate:
        raise AuthError({"code": "authorization_header_missing",
                         "description":
                         "Authorization header is expected"}, 401)

    authenticate = authenticate.split()

    if authenticate[0].lower() != "bearer":
        raise AuthError({"code": "invalid_header",
                         "description":
                         "Authorization header must start with"
                         " Bearer"}, 401)
    elif len(authenticate) != 1:
        raise AuthError({"code": "invalid_header",
                         "description": "Wrong number of tokens found"}, 401)

    return authenticate[1]

def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        try:
            token = get_token_auth_header()
            jsonurl = urlopen("https://" +
                              TENANT_NAME + ".b2clogin.com/" +
                              TENANT_NAME + ".onmicrosoft.com/" +
                              B2C_POLICY + "/discovery/v2.0/keys")
            jwks = json.loads(jsonurl.read())
            unverified_header = jwt.get_unverified_header(token)
            rsa_key = {}
            for key in jwks["keys"]:
                if key["kid"] == unverified_header["kid"]:
                    rsa_key = {
                        "kty": key["kty"],
                        "kid": key["kid"],
                        "use": key["use"],
                        "n": key["n"],
                        "e": key["e"]
                    }
        except Exception:
            raise AuthError({"code": "invalid_header",
                             "description":
                             "Unable to parse authentication"
                             " token."}, 401)
        if rsa_key:
            try:
                payload = jwt.decode(
                    token,
                    rsa_key,
                    algorithms=["RS256"],
                    audience=CLIENT_ID,
                    issuer="https://" + TENANT_NAME +
                    ".b2clogin.com/" + TENANT_ID + "/v2.0/"
                )
            except jwt.ExpiredSignatureError:
                raise AuthError({"code": "token_expired",
                                 "description": "token is expired"}, 401)
            except jwt.JWTClaimsError:
                raise AuthError({"code": "invalid_claims",
                                 "description":
                                 "incorrect claims,"
                                 "please check the audience and issuer"}, 401)
            except Exception:
                raise AuthError({"code": "invalid_header",
                                 "description":
                                 "Unable to parse authentication"
                                 " token."}, 401)
            _request_ctx_stack.top.current_user = payload
            return f(*args, **kwargs)
        raise AuthError({"code": "invalid_header",
                         "description": "Unable to find appropriate key"}, 401)
    return decorated

def requires_scope(required_scope):
    """Determines if the required scope is present in the Access Token
    Args:
        required_scope (str): The scope required to access the resource
    """
    token = get_token_auth_header()
    unverified_claims = jwt.get_unverified_claims(token)
    if unverified_claims.get("scp"):
        token_scopes = unverified_claims["scp"].split()
        for token_scope in token_scopes:
            if token_scope == required_scope:
                return True
    raise AuthError({
        "code": "Unauthorized",
        "description": "You don't have access to this resource"
    }, 403)

class Preferences(Resource):
    @requires_auth
    def get(self):
        if (requires_scope("Accounts.Read")):
            args = preferences_delete_args.parse_args()
            conn = psycopg2.connect(DB_CONNECTION_STRING)
            result = ""
            with conn.cursor() as curr:
                curr.execute(f"SELECT * from favourites WHERE username = \'{args['username']}\' LIMIT 1")
                result = curr.fetchall()
                conn.commit()
            conn.close()
        return result

    @requires_auth
    def put(self):
        if (requires_scope("Accounts.Write")):
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
        else:
            return 400

    @requires_auth
    def patch(self):
        if (requires_scope("Accounts.Write")):
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
        else:
            return 400

    @requires_auth
    def delete(self):
        if (requires_scope("Accounts.Write")):
            delete_name = request.headers.get("username")
            conn = psycopg2.connect(DB_CONNECTION_STRING)
            with conn.cursor() as curr:
                curr.execute(f"DELETE FROM preferences WHERE username = \'{delete_name}\'")
                conn.commit()
            conn.close()
            return 200
        else:
            return 400

class query_recipes(Resource):
    @requires_auth
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
        oldquerystr = ""
        for i in range(10):
            try:
                oldquerystr = querystr
                querystr += str(data['results'][i-1]['id']) + ","
            except:
                querystr = oldquerystr
                break
        querystr = querystr[:-1]
        querystring = {"ids": querystr}
        querystring = json.dumps(querystring)
        url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/informationBulk"
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY}, params={"ids": querystr})
        return response.json()

class Favourites(Resource):
    @requires_auth
    def get(self):
        if (requires_scope("Accounts.Read")):
            args = favourites_get_args.parse_args()
            conn = psycopg2.connect(DB_CONNECTION_STRING)
            result = ""
            with conn.cursor() as curr:
                curr.execute(f"SELECT * from favourites WHERE username = \'{args['username']}\' LIMIT 10")
                result = curr.fetchall()
                conn.commit()
            conn.close()
        return result

    @requires_auth
    def put(self):
        if (requires_scope("Accounts.Write")):
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
            return 200
        else:
            return 400

    @requires_auth
    def patch(self):
        if (requires_scope("Accounts.Write")):
            args = favourites_patch_args.parse_args()
            conn = psycopg2.connect(DB_CONNECTION_STRING)
            with conn.cursor() as curr:
                curr.execute(f"UPDATE favourites SET rating = \'{args['rating']}\' WHERE username = \'{args['username']}\' AND recipe_id = \'{args['recipe_id']}\'")
                conn.commit()
            conn.close()
            return 200
        else:
            return 400

    @requires_auth
    def delete(self):
        if (requires_scope("Accounts.Write")):
            delete_name = request.headers.get("username")
            delete_id = request.headers.get("request_id")
            conn = psycopg2.connect(DB_CONNECTION_STRING)
            with conn.cursor() as curr:
                curr.execute(f"DELETE FROM favourites WHERE username = \'{delete_name}\' AND recipe_id = \'{delete_id}\'")
                conn.commit()
            conn.close()
            return 200
        else:
            return 400

class query_random(Resource):
    @requires_auth
    def get(self):
        args = query_random_args.parse_args()
        url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=10&"
        if (args['tags']):
            url += f"tags = {args['tags']}"
        response = requests.get(url, headers={"X-RapidAPI-Key": KEY})
        return response

class query_by_id(Resource):
    @requires_auth
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