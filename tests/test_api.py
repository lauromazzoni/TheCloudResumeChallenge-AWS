import requests

#API_URL = "https://b1g432dvy6.execute-api.us-east-1.amazonaws.com/prod/counter"
API_URL = "https://abc123.execute-api.us-east-1.amazonaws.com/prod/counter"


def test_counter_returns_status_200():
    r = requests.get(API_URL)
    assert r.status_code == 200

def test_counter_returns_json():
    r = requests.get(API_URL)
    data = r.json()
    # a resposta tem "body" porque é proxy integration
    assert "body" in data
    

def test_counter_has_visits_key():
    r = requests.get(API_URL)
    data = r.json()
    body = data.get("body")
    assert body is not None
    parsed = eval(body) if isinstance(body, str) else body
    assert "visits" in parsed
    assert isinstance(parsed["visits"], int)

