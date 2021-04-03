"use strict";

const { getContainer } = require("../auth");
const data = require("../data.json");
const { SPROC_NAME } = require("./");

const getRandomItem = () => {
    const length = data.length;
    const randomIndex = Math.floor(Math.random() * length);

    return data[randomIndex];
};

const main = async() => {
    const newItem = getRandomItem();
    const container = getContainer();

    const options = {
        enableScriptLogging: true
    };

    console.log(newItem);

    await container.scripts.storedProcedure(SPROC_NAME).execute(newItem.employeeId, [JSON.stringify(newItem)], options);
    console.log("Stored procedure executed...");
};

main().catch(err => console.error(err));
