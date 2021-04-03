"use strict";

const { getContainer } = require("../auth");
const { TRIGGER_NAME } = require("./");

const triggers = [
    {
        body: require("./code"),
        id: TRIGGER_NAME,
        triggerOperation: "Create",
        triggerType: "pre"
    }
];

const createTriggers = async container => {
    for (const trigger of triggers) {
        await container.scripts.triggers.create(trigger);
        console.log(`Created the trigger. Type: ${trigger.triggerType} ID: ${trigger.id}`);
    }
};

const updateTriggers = async container => {
    for (const trigger of triggers) {
        await container.scripts.trigger(trigger.id).replace(trigger);
        console.log(`Updated the trigger. Type: ${trigger.triggerType} ID: ${trigger.id}`);
    }
};

const doTriggersAlreadyExist = async container => {
    const result = await container.scripts.triggers.readAll().fetchAll();

    // This works because we are the only ones adding triggers here, you
    // would want additional logic for a team
    const doesExist = (result.resources.length === triggers.length);

    console.log(`Triggers: ${result.resources.length} defined`);
    console.log(doesExist ? "Triggers already exists" : "Triggers do not exist");
    return doesExist;
};

const main = async() => {
    const container = getContainer();

    if (await doTriggersAlreadyExist(container)) {
        await updateTriggers(container);
    } else {
        await createTriggers(container);
    }
};

main().catch(err => console.error(err));
