"use strict";

const { getContainer } = require("../auth");
const data = require("../data.json");
const { TRIGGER_NAME } = require("./");

console.log(`Trigger Name: ${TRIGGER_NAME}`);

const getRandomItem = () => {
    const length = data.length;
    const randomIndex = Math.floor(Math.random() * length);

    const item = data[randomIndex];

    return {
        employeeId: item.employeeId,
        id: item.id,
        firstName: item.firstName,
        surname: item.lastName,
        country: item.country,
        region: (item.country === "US") ? "NA" : "INTL",
        email: `${item.firstName}.${item.lastName}@globomantics.com`
    };
};

const main = async() => {
    const newItem = getRandomItem();
    const container = getContainer();

    const options = {
        enableScriptLogging: true,
        preTriggerInclude: [TRIGGER_NAME]
    };

    console.log(newItem);

    await container.items.create(newItem, options);
    console.log("Data added with preTrigger executed...");
};

main().catch(err => console.error(err));
