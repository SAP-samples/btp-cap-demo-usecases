const cds = require("@sap/cds");
const { setTimeout } = require("timers/promises");

module.exports = cds.service.impl(async function (srv) {

    srv.on("getData", async (req) => {

        if (req.data.wait && !req.res._headerSent) {
            console.log('[DB] reading data from db - started!');
            await setTimeout(5 * 1000);
            console.log('[DB] reading data from db - finished!');
        }
        
        if (req.data.wait && !req.res._headerSent) {
            console.log('[API] reading data from api - started!');
            await setTimeout(5 * 1000);
            console.log('[API] reading data from api - finished!');
        }
        
        if (req.data.wait && !req.res._headerSent) {
            console.log('processing both sets of data started!');
            await setTimeout(5 * 1000);
            console.log('processing both sets of data finished!');
        }
        
        return ['StringData1', 'StringData2'];

    })

})