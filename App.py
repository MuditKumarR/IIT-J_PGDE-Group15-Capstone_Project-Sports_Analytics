import streamlit as st
import pandas as pd
import joblib
import snowflake.connector
from sklearn.preprocessing import LabelEncoder

# ---- FUNCTION TO CONNECT TO SNOWFLAKE AND FETCH UNIQUE VALUES ----
@st.cache_data
def fetch_unique_values():
    conn = snowflake.connector.connect(
        user='mudit',
        password='Pappu@123',
        account='yw44584.ap-southeast-1',
        warehouse='COMPUTE_WH',
        database='CAPSTONE_PROJECT',
        schema='SPORTS'
    )
    query = """
        SELECT DISTINCT weather,   team1,   team2,   location
        FROM sports_data_final
    """
    data = pd.read_sql(query, conn)
    conn.close()

    # Combine team1 and team2 into a single list of unique teams
    data.columns = data.columns.str.strip().str.lower()

    unique_teams = pd.concat([data['team1'], data['team2']]).dropna().unique()
    unique_weather = data['weather'].dropna().unique()
    unique_locations = data['location'].dropna().unique()
    
    return unique_weather, unique_teams, unique_locations

# ---- FUNCTION TO LOAD THE MODEL AND ENCODERS ----
@st.cache_resource
def load_model_and_encoders():
    # Load the saved model
    model = joblib.load("LightGBM_best_model.sav")
    
    # Create LabelEncoders
    unique_weather, unique_teams, unique_locations = fetch_unique_values()
    label_encoders = {
        'weather': LabelEncoder().fit(unique_weather),
        'team1': LabelEncoder().fit(unique_teams),
        'team2': LabelEncoder().fit(unique_teams),
        'location': LabelEncoder().fit(unique_locations)
    }
    return model, label_encoders

# ---- STREAMLIT APP UI ----
st.title("IIT- J Capstone Project")
st.title("Sports Analytics- Match Outcome Predictor ⚽")

st.subheader("Group 15 - Mudit , Anup , Abhinandan , Keyur , Pariniti")

# Fetch dropdown values
unique_weather, unique_teams, unique_locations = fetch_unique_values()
model, label_encoders = load_model_and_encoders()

# User input through Streamlit widgets
st.subheader("Enter Match Details")
weather = st.selectbox("Select Weather Condition:", unique_weather)
team1 = st.selectbox("Select Team 1:", unique_teams)
team2 = st.selectbox("Select Team 2:", unique_teams)
location = st.selectbox("Select Location:", unique_locations)
attendance = st.number_input("Enter Attendance:", min_value=0, step=1000)

# Submit button
if st.button("Predict Match Outcome"):
    # Prepare input data
    new_data = pd.DataFrame([{
        'weather': weather,
        'team1': team1,
        'team2': team2,
        'location': location,
        'attendance': attendance
    }])

    # Encode input features
    for col in ['weather', 'team1', 'team2', 'location']:
        new_data[col] = label_encoders[col].transform(new_data[col])
    new_data = new_data.astype(float)

    # Perform prediction
    prediction = model.predict(new_data)

    # Interpret prediction
    team1_name = team1
    team2_name = team2
    if prediction[0] == 1:
        st.success(f"🏆 Prediction: **{team1_name} Wins!** 🏆")
    elif prediction[0] == 0:
        st.success(f"🏆 Prediction: **{team2_name} Wins!** 🏆")
    else:
        st.success(f"🤝 Prediction: Match Between **{team1_name}** and **{team2_name}** is a Draw 🤝")
