const cds = require("@sap/cds");
const apiMalwareScan = require("./resources/service-clients/MalwareScanAPI/default-api")
const { Readable, PassThrough } = require('stream')
module.exports = cds.service.impl(async function (srv) {

  const { MediaFiles } = this.entities;

  srv.on('PUT', MediaFiles, async (req, res, next) => {

    const stream = new PassThrough()
    const chunks = []
    stream.on('data', chunk => chunks.push(chunk));
    
    stream.on('end', async (req) => {
      let body = Buffer.concat(chunks).toString('binary');
      let requestBuilder = await apiMalwareScan.DefaultApi.createScan(body);
      requestBuilder.addCustomHeaders({ 'Content-Type': 'application/octet-stream' });
      requestBuilder.addCustomHeaders({ 'Accept': 'application/json' });
      let response = await requestBuilder.skipCsrfTokenFetching().execute({ destinationName: 'cap-media-malwarescanner-dest' });
      console.log(response);
      if (response.malwareDetected) {
        req.error(500, 'Malware Detected');
      }
    })
    req.data.content.pipe(stream);
  });

})