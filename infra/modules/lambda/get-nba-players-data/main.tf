/* ---------------------------------------------------------
    FILE: main.tf @ lambda-nba-players module

    The main file from this submodule created to define
    all resources and its rules.

    GOAL:
        To deploy a scheduled AWS Lambda function to get
        information about NBA players from nba_api endpoint
        calls. The data will be stored in CSV files in S3.

    RESOURCES:
        - Lambda
        - Eventbridge
--------------------------------------------------------- */
