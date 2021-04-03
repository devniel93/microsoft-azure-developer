"use strict";

const { getContainer, getDatabase, CONTAINER_NAME } = require("./auth");

const main = async() => {
    try {
        await getContainer().delete();
        console.log("Container deleted....");
    } catch (err) {
        console.log("Container did not exist....");
    }

    await getDatabase().containers.createIfNotExists({ id: CONTAINER_NAME, partitionKey: "/employeeId" });
    console.log("Container re-created....");
};

main().catch(err => console.error(err));
