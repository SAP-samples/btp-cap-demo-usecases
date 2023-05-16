const cds = require("@sap/cds");
module.exports = cds.service.impl(async function (srv) {

    const { Roots, Roots2 } = cds.entities;

    srv.on('testCQLExamples', async (req) => {
        let result;
        result = await SELECT.from(Roots).columns('name',`asitem.asi_sfield`)
        console.log(result);
        return 'It Works!!'
    });

});

