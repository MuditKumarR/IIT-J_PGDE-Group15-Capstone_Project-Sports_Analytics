Create OR REPLACE DATABASE CAPSTONE_PROJECT;

CREATE OR REPLACE SCHEMA CAPSTONE_PROJECT.SPORTS;


---Creation of INTEGRATION OBJECT---------
--------------------------------------------
CREATE STORAGE INTEGRATION s3_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::061051237752:role/capstone-project-sf-s3-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://capstone-project-iitj/');


  DESC INTEGRATION s3_integration;


---Creation of FILE FORMAT OBJECT---------
--------------------------------------------
  
  CREATE FILE FORMAT my_csv_format
  TYPE = CSV
  FIELD_DELIMITER = ','
  RECORD_DELIMITER = '\n'
  SKIP_HEADER = 1;
  
---Creation of EXTERNAL STAGE OBJECT---------
--------------------------------------------

  CREATE STAGE my_external_stage
  URL = 's3://capstone-project-iitj/'
  STORAGE_INTEGRATION = s3_integration
  FILE_FORMAT = (FORMAT_NAME = my_csv_format);

  LIST @my_external_stage ;



---Creation of INTRIM TABLE FOR STAGING THE DATA AS IS---------
--------------------------------------------

  
  CREATE OR REPLACE TABLE sports_data_intrim (
  MatchID VARCHAR(255),
  Team1 VARCHAR(255),
  Team2 VARCHAR(255),
  Team1_Score INTEGER,
  Team2_Score INTEGER,
  Date VARCHAR(255),
  Location VARCHAR(255),
  Weather VARCHAR(255),
  Attendance INTEGER,
  Team1_Possession FLOAT,
  Team2_Possession FLOAT,
  Shots_On_Target_Team1 INTEGER,
  Shots_On_Target_Team2 INTEGER,
  Fouls_Team1 INTEGER,
  Fouls_Team2 INTEGER,
  Yellow_Cards_Team1 INTEGER,
  Yellow_Cards_Team2 INTEGER,
  Red_Cards_Team1 INTEGER,
  Red_Cards_Team2 INTEGER,
  PlayerID VARCHAR(255),
  PlayerName VARCHAR(255),
  Position VARCHAR(255),
  Goals INTEGER,
  Assists INTEGER,
  Minutes_Played INTEGER
);


---Creation of SNOW PIPE OBJECT---------
--------------------------------------------


CREATE OR REPLACE PIPE my_snowpipe
  AUTO_INGEST = TRUE
  AS
  COPY INTO sports_data_intrim
  FROM @my_external_stage/Sports_data/
  FILE_FORMAT = (FORMAT_NAME = my_csv_format);

  DESC PIPE my_snowpipe;

  
  ---Creation of STREAM OBJECT---------
--------------------------------------------


 

CREATE OR REPLACE STREAM sports_data_stream ON TABLE sports_data_intrim APPEND_ONLY =TRUE;



  ---Creation of TASK OBJECT---------
--------------------------------------------


CREATE OR REPLACE TASK transform_sports_data
  WAREHOUSE = COMPUTE_WH  -- Replace with your warehouse name
  SCHEDULE = '1 MINUTE'  -- Adjust the schedule as needed
  WHEN SYSTEM$STREAM_HAS_DATA('sports_data_stream')  -- Conditional execution
AS
  -- Insert transformed data into the final table (sports_data_final)
  INSERT INTO sports_data_final (
    MatchID, 
    Team1, 
    Team2, 
    Team1_Score, 
    Team2_Score, 
    Date, 
    Location, 
    Weather, 
    Attendance, 
    Team1_Possession, 
    Team2_Possession, 
    Shots_On_Target_Team1,
    Shots_On_Target_Team2, 
    Fouls_Team1, 
    Fouls_Team2, 
    Yellow_Cards_Team1, 
    Yellow_Cards_Team2, 
    Red_Cards_Team1,
    Red_Cards_Team2,
    PlayerID, 
    PlayerName, 
    Position, 
    Goals, 
    Assists, 
    Minutes_Played/*,
    -- Add your transformed columns here
    Total_Fouls,  
    Total_Yellow_Cards,
    Total_Red_Cards*/
  )
  SELECT 
    MatchID, 
    Team1, 
    Team2, 
    Team1_Score, 
    Team2_Score, 
    Date, 
    Location, 
    Weather, 
    Attendance, 
    Team1_Possession, 
    Team2_Possession, 
    Shots_On_Target_Team1,
    Shots_On_Target_Team2, 
    Fouls_Team1, 
    Fouls_Team2, 
    Yellow_Cards_Team1, 
    Yellow_Cards_Team2, 
    Red_Cards_Team1,
    Red_Cards_Team2,
    PlayerID, 
    PlayerName, 
    Position, 
    Goals, 
    Assists, 
    Minutes_Played,
    
    -- Calculate total fouls
    Fouls_Team1 + Fouls_Team2 Total_Fouls ,
    -- Calculate total yellow cards
    Yellow_Cards_Team1 + Yellow_Cards_Team2 total_yellow_cards,
    -- Calculate total red cards
    Red_Cards_Team1 + Red_Cards_Team2 total_red_cards ,
    T.REALISTIC_TEAM TEAM1_NAME,
    TT.REALISTIC_TEAM TEAM2_NAME,
    L.REALISTIC_LOCATION LOCATION_NAME
  FROM sports_data_stream S LEFT JOIN TEAM_MAPPING T 
    ON S.TEAM1 = T.GENARATED_MAPPING
    LEFT JOIN TEAM_MAPPING TT ON S.TEAM2 = TT.GENERATED_MAPPING
    LEFT JOIN LOCATION_MAPPING L ON S.LOCATION = L.GENERATED_LOCATION
  ;

  ALTER TASK  transform_sports_data RESUME;
  

SELECT DISTINCT weather,team1,team2,location
        FROM sports_data_final

  SELECT weather, team1, team2, location, attendance, team1_score, team2_score FROM sports_data_final;