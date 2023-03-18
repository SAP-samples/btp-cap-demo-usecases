const cds = require("@sap/cds");

class service extends cds.ApplicationService {
    async init() {
        const { Customers, EmailAddresses } = this.entities;

        this.after("PATCH", EmailAddresses, async (data) => {
            let customerInfo = { email: '' }, addressInfo='';
            let result = await cds.read(EmailAddresses.drafts).where({ ID: data.ID }).columns(["customer_ID"]);

            let dbItemInfos = await cds.read(EmailAddresses.drafts).where({ customer_ID: result[0].customer_ID });
            addressInfo = dbItemInfos.find(emailAddress => emailAddress.emailType_id == '4');
            if(addressInfo == undefined || addressInfo.emailAddress == ''){
                addressInfo = dbItemInfos.find(emailAddress => emailAddress.emailType_id == '2');
            }
            if(addressInfo == undefined || addressInfo.emailAddress == ''){
                addressInfo = dbItemInfos.find(emailAddress => emailAddress.emailType_id == '1');
            }
            if(addressInfo && addressInfo != undefined){
                customerInfo.email = addressInfo.emailAddress;
            }
            await cds.update(Customers.drafts, result[0].customer_ID).set(customerInfo);
        });
        await super.init();
    }
}
module.exports = service;