"use strict";

const { getContainer } = require("../auth");
const { SPROC_NAME } = require("./");

const createStoredProcedure = async container => {
    await container.scripts.storedProcedures.create({ body: require("./code"), id: SPROC_NAME });
    console.log(`Created the stored procedure: ${SPROC_NAME}`);
};

const updateStoredProcedure = async container => {
    await container.scripts.storedProcedure(SPROC_NAME).replace({ body: require("./code"), id: SPROC_NAME });
    console.log(`Updated the stored procedure: ${SPROC_NAME}`);
};

const doesStoredProcedureAlreadyExist = async(container, id) => {
    const querySpec = {
        query: "SELECT * FROM root r WHERE r.id = @sproc",
        parameters: [
            { name: "@sproc", value: id }
        ]
    };
    const result = await container.scripts.storedProcedures.query(querySpec).fetchAll();
    const doesExist = (result.resources.length > 0);

    console.log(doesExist ? "Stored procedure already exists" : "Stored prodecure does not exist");
    return doesExist;
};

const main = async() => {
    const container = getContainer();

    if (await doesStoredProcedureAlreadyExist(container, SPROC_NAME)) {
        await updateStoredProcedure(container);
    } else {
        await createStoredProcedure(container);
    }
};

main().catch(err => console.error(err));
