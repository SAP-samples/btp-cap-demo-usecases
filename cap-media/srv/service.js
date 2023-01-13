const cds = require("@sap/cds");
const apiMalwareScan = require("./resources/service-clients/MalwareScanAPI/default-api")
const { Readable, PassThrough } = require('stream')

module.exports = cds.service.impl(async function (srv) {
  const { MediaFiles } = this.entities;

  srv.on('PUT', MediaFiles, async (req, next) => {
    const url = req._.req.path, chunks = [];
    if (url.includes('content')) {

      let mediaMalwareScanner = function (req) {
        let malwarescan = new Promise(function (resolve, reject) {
          req.data.content.on('data', chunk => chunks.push(chunk));
          req.data.content.on('end', async (req) => {
            let body = Buffer.concat(chunks).toString('binary');
            let requestBuilder = await apiMalwareScan.DefaultApi.createScan(body);
            requestBuilder.addCustomHeaders({ 'Content-Type': 'application/octet-stream' });
            requestBuilder.addCustomHeaders({ 'Accept': 'application/json' });
            let response = await requestBuilder.skipCsrfTokenFetching().execute({ destinationName: 'cap-media-malwarescanner-dest' });
            resolve(response.malwareDetected);
          });
        });
        return malwarescan;
      }

      let isMalwareDetected = await mediaMalwareScanner(req);
      if (isMalwareDetected) {
        req.error(500, 'Malware Detected');
      } else {
        req.data.content = new PassThrough();
        req.data.content.push(Buffer.concat(chunks));
        req.data.content.push(null);
        next()
      }

    } else {

      return next();

    }

  });

})