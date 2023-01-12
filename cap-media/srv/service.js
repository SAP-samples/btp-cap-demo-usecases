const cds = require("@sap/cds");
const apiMalwareScan = require("./resources/service-clients/MalwareScanAPI/default-api")
const { Readable, PassThrough } = require('stream')

module.exports = cds.service.impl(async function (srv) {
  const { MediaFiles } = this.entities;

  srv.on('PUT', MediaFiles, async (req, next) => {

    let mediaMalwareScanner = function (req) {
      let malwarescan = new Promise(function (resolve, reject) {
        const stream = new PassThrough(), chunks = []
        stream.on('data', chunk => chunks.push(chunk));
        stream.on('end', async (req) => {
          let body = Buffer.concat(chunks).toString('binary');
          let requestBuilder = await apiMalwareScan.DefaultApi.createScan(body);
          requestBuilder.addCustomHeaders({ 'Content-Type': 'application/octet-stream' });
          requestBuilder.addCustomHeaders({ 'Accept': 'application/json' });
          let response = await requestBuilder.skipCsrfTokenFetching().execute({ destinationName: 'cap-media-malwarescanner-dest' });
          resolve(response.malwareDetected);
        });
        req.data.content.pipe(stream);
      });
      return malwarescan;
    }

    let isMalwareDetected = await mediaMalwareScanner(req);
    isMalwareDetected ? req.error(500, 'Malware Detected') : next();

  });

})