"""A lambda function definition to get data about NBA players.

This function is responsible to call nba_api python package endpoints through
the nbaflow python package in order to get data about NBA players in a pandas
DataFrame format and store it on S3 to be available in other analytics services
such as Athena and Glue.

___
"""

# Importing libraries
from nbaflow.utils.log import log_config
from nbaflow.utils.requests import handle_timeout_errors
from nbaflow.players import get_players_data

import json


# Getting and setting up a logger object
logger = log_config(__file__)

def lambda_handler(event, context):
    """
    """

    # Getting data from NBA players
    logger.info("Getting data from NBA players")
    df_players = get_players_data(timeout=10, only_active_players=False)
    logger.info(df_players.shape)

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }