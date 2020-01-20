#import requests
#response = requests.post('https://events-api.notivize.com/applications/a0d32a6b-b502-4ada-b8d9-71960475dcd6/event_flows/0472de9d-10bc-45ca-a738-1d896422083a/events', json={"lifecycle_stage": "create", "start": True, "theemail": "momokingdean@gmail.com"})
#print(response)
bac = .08
friend = "Jesus"
location = "https://www.google.com/maps/@36.9981857,-122.0575634,15z"
import requests
response = requests.post('https://events-api.notivize.com/applications/a0d32a6b-b502-4ada-b8d9-71960475dcd6/event_flows/0472de9d-10bc-45ca-a738-1d896422083a/events', json={"bac": bac, "friend": friend, "lifecycle_stage": "create", "location": "https://www.google.com/maps/@36.9981857,-122.0575634,15z", "start": True, "theemail": "momokingdean@gmail.com", "user": "Dean"})
print(response)