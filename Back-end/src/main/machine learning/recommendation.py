import numpy as np
from annoy import AnnoyIndex
from fastapi import FastAPI
import mysql.connector

def get_data():
    # Property data as a dictionary
    property_data = {}

    # Establish a connection
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="semsark"
    )

    # Create a cursor
    cursor = conn.cursor()

    # Execute a query
    query = "SELECT * FROM building"
    cursor.execute(query)

    # Fetch and process the results
    results = cursor.fetchall()

    cursor.close()
    conn.close()

    for data in results:
        property_id = data[0]
        property_data[property_id] = {
            'halls': data[15],
            'bedroom': data[16],
            'bathroom': data[14],
            'size_sqm': data[3],
            'price': data[17],
            'gov': data[10],
            'city': data[5],
            'type': data[21]
        }
    return property_data


# Define the function to recommend properties based on location
def recommend_properties_location(property_id, property_data):
    # Get the location of the property with the given id
    city = property_data[property_id]['city']

    # Filter properties by location
    similar_properties = [
        pid for pid, prop in property_data.items() if prop['city'] == city and pid != property_id
    ]

    # If no properties are found in the same city, check the secondary city attribute
    gov = property_data[property_id]['gov']
    similar_properties += [
        pid for pid, prop in property_data.items() if prop['gov'] == gov and pid != property_id
    ]

    return similar_properties


# Define the function to recommend properties based on type
def recommend_by_type(property_id, property_ids, property_type, property_data, location_similar=None):
    # Filter the property_ids list by type
    properties_of_type = [
        pid for pid in property_ids if property_data[pid]['type'] == property_type and pid != property_id
    ]

    if location_similar is not None:
        # Further filter properties by location similarity
        properties_of_type_and_location = [
            pid for pid in properties_of_type if pid in location_similar
        ]
        return properties_of_type_and_location
    else:
        return properties_of_type


# Define the function to recommend properties based on other features using kNN
def recommend_by_features(property_id, property_ids, property_data):
    # Define the number of trees for AKNN
    num_trees = 100

    # Extract features of the input property
    input_property_features = np.array([
        property_data[property_id]['halls'],
        property_data[property_id]['bedroom'],
        property_data[property_id]['bathroom'],
        property_data[property_id]['size_sqm'],
        property_data[property_id]['price']
    ]).reshape(1, -1)

    # Extract features of the properties with the given property_ids
    property_ids_features = np.array([
        [
            property_data[pid]['halls'],
            property_data[pid]['bedroom'],
            property_data[pid]['bathroom'],
            property_data[pid]['size_sqm'],
            property_data[pid]['price']
        ] for pid in property_ids
    ])

    # Initialize the AKNN index
    index = AnnoyIndex(input_property_features.shape[1], metric='angular')

    # Add the properties to the index
    for i, feature in enumerate(property_ids_features):
        index.add_item(i, feature)

    # Build the index
    index.build(num_trees)

    # Find the nearest neighbors of the input property in the index
    nearest_neighbors = index.get_nns_by_vector(input_property_features[0], 5)

    # Map the indices of the nearest neighbors to the property ids
    similar_properties = [property_ids[i] for i in nearest_neighbors]

    return similar_properties


def final_recommend_properties(property_id, property_data):
    # Get similar properties based on location
    location_similar = recommend_properties_location(property_id, property_data)

    # If there are no similar properties based on location, get similar properties based on type
    if len(location_similar) == 0:
        property_type = property_data[property_id]['type']
        type_similar = recommend_by_type(property_id, (property_data.keys()), property_type, property_data)
    else:
        property_type = property_data[property_id]['type']
        type_similar = recommend_by_type(property_id, (property_data.keys()), property_type, property_data,
                                         location_similar)

    # If there are no similar properties based on location or type, get similar properties based on features
    if len(location_similar) == 0 and len(type_similar) == 0:
        features_similar = recommend_by_features(property_id, list(property_data.keys()), property_data)
    else:
        features_similar = recommend_by_features(property_id, type_similar, property_data)

    return features_similar
# Create an instance of the FastAPI app
app = FastAPI()


# Define the API route and the corresponding function
@app.get("/{property_id}")
def recommend_properties(property_id: int):
    # Property data as a dictionary
    property_data = get_data()
    recommendations = final_recommend_properties(property_id, property_data)
    return recommendations