"use strict";

async function importEmployeesData(record) {
    const context = getContext(); // eslint-disable-line no-undef
    const container = context.getCollection();

    const createItem = async parsedRecord => new Promise((resolve, reject) => {

        /*
          SAMPLE DATA OBJECT
          {
            "id":"84ea1713-d3b8-488e-9d8f-98de2c5b761c",
            "firstName":"Bondon",
            "lastName":"Glanz",
            "country":"CN",
            "employeeId":"db934626-6f4b-49a4-b5d1-2a965e230444"
          }
        */
        const item = {
            employeeId: parsedRecord.employeeId,
            id: parsedRecord.id,
            firstName: parsedRecord.firstName,
            surname: parsedRecord.lastName,
            country: parsedRecord.country,
            region: (parsedRecord.country === "US") ? "NA" : "INTL",
            email: `${parsedRecord.firstName}.${parsedRecord.lastName}@globomantics.com`
        };

        container.createDocument(container.getSelfLink(), item, (err, result, options) => {
            if (err) {
                reject(err);
            }
            resolve({ result, options });
        });

    });

    const main = async() => {
        const parsedRecord = JSON.parse(record);

        await createItem(parsedRecord, container);
    };

    main().catch(err => getContext().abort(err)); // eslint-disable-line no-undef
}

module.exports = importEmployeesData;
