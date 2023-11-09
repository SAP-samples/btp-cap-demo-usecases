/* eslint-disable no-undef */

const cds = require("@sap/cds");
const resilienceTimeout = require("./resilience_timeout");

const options = {};
options.timeout = 10000;
options.onTimeout = function (req, res) {
  let message = { errorCode: "TimeOutError", 
                  errorMessage: "Your request could not processed within a timeframe" };
  res.status(500).send(JSON.stringify(message));
};

cds.middlewares.add(resilienceTimeout.timeoutHandler(options));

module.exports = cds.server;
