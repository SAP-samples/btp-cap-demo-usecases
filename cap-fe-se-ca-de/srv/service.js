const cds = require('@sap/cds')

class service extends cds.ApplicationService {

  async init() {
    const { Orders, OrderItems, Products } = this.entities

    this.before('PATCH', OrderItems, async req => {

      let productInfo, price, quantity, dbItemInfo;

      //When product is available, fill price and currency
      if (req.data.product_id != undefined && req.data.product_id != null) {
        productInfo = await cds.read(Products).byKey(req.data.product_id);
        req.data.price = productInfo.price;
        req.data.currency_code = productInfo.currency_code;
      }

      // Calculate Net Price
      dbItemInfo = await cds.read(OrderItems.drafts).where({ ID: req.data.ID });
      req.data.price > 0 ? price = req.data.price : price = dbItemInfo[0].price;
      req.data.quantity > 0 ? quantity = req.data.quantity : quantity = dbItemInfo[0].quantity;
      if (price > 0 && quantity > 0) {
        req.data.netprice = price * quantity;
        req.data.netprice = Math.round((req.data.netprice + Number.EPSILON) * 100) / 100;
      }

    });

    this.after('PATCH', OrderItems, async data => {

      let orderInfo = { totamount: 0 };
      let result = await cds.read(OrderItems.drafts)
                            .where({ ID: data.ID })
                            .columns(['order_ID']);
      let dbItemInfos = await cds.read(OrderItems.drafts).where({ order_ID: result[0].order_ID });
      for (let i = 0; i < dbItemInfos.length; i++) {
        if (dbItemInfos[i].netprice > 0) {
          orderInfo.totamount = orderInfo.totamount + dbItemInfos[i].netprice;
        }
        orderInfo.currency_code = dbItemInfos[i].currency_code;
      }
      await cds.update(Orders.drafts, result[0].order_ID).set(orderInfo);

    });

    this.on('setOrderProcessing', Orders, async req => {
      await cds.update(Orders, req.params[0].ID).set({status: 'In Process'});
    });

    this.on('setOrderOpen', Orders, async req => {
      await cds.update(Orders, req.params[0].ID).set({status: 'Open'});
    });

    this.on('getOrderDefaults', async req => {
      return {status: 'Open'};
    });

    await super.init()
  }

};
module.exports = service
