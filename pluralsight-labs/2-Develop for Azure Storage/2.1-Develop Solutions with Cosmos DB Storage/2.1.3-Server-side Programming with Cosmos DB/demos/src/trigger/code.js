"use strict";

function preEmployeeTrigger() {
    const context = getContext(); // eslint-disable-line no-undef
    const request = context.getRequest();
    const newItem = request.getBody();

    // Add fullname
    if (!("fullName" in newItem)) {
        newItem.fullName = `${newItem.firstName} ${newItem.surname}`;
    }

    // Email regular expression (from Chromium)
    const emailRegExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (!emailRegExp.test(newItem.email)) {
        throw new Error(`Invalid email address: ${newItem.email}`);
    }

    request.setBody(newItem);
}

module.exports = preEmployeeTrigger;
