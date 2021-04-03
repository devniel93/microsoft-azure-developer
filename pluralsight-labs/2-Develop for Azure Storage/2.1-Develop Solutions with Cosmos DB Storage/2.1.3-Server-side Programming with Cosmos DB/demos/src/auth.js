"use strict";

const { CosmosClient } = require("@azure/cosmos");

const endpoint = "<insert endpoint>";
const key = "<insert database key>";
const databaseName = "sampledb";
const containerName = "samplecontainer";

// DON'T EDIT BELOW THIS LINE ------------------------

const client = new CosmosClient({ endpoint, key });
const database = client.database(databaseName);

module.exports.getContainer = () => database.container(containerName);
module.exports.getDatabase = () => database;
module.exports.CONTAINER_NAME = containerName;
