const cds = require("@sap/cds");
module.exports = cds.service.impl(async function (srv) {
    const { Roots, Items, Categories, Samples } = cds.entities;

    /*---------->> Handlers for Unbound Acions <<----------*/
    srv.on(
        [
            "ga_op_ub_replication",
            "ta_lr_ub_toolbarAction",
            "fg_op_ub_triggerRefresh",
            "ca_op_ub_chartAction",
            "da_op_ub_clearOutstanding",
            "sua_action_critical",
        ],
        async (req) => {
            req.notify(`${req.event} \n\n unbound action triggered`);
        }
    );

    srv.on("msg_trigger",async (req) => {
      req._.res.setHeader('sap-messages', JSON.stringify([
        { 
          "code" : "500",
          "message" : "info: messages trigger action called!",
          "numericSeverity" : 2                            
        },
        {
          "code" : "504",
          "message" : "This can only be triggered for draft data",
          "numericSeverity" : 3
        },
        {
          "code" : "504",
          "message" : "Error happened! Contact your IT Admin",
          "numericSeverity" : 4
        }
      ]));
    });

    /*---------->> Handlers for Bound Global Acions <<----------*/
    srv.on("ga_op_calculate", async (req) => {
        console.log("🚀 [file: service.js] [ga_op_calculate] ~ req.params:", req.params);
        req.info(`ga_op_calculate \n\n action triggered with context: \n\n ${JSON.stringify(req.params)}`);
    });

    /*---------->> Handlers for Bound Acions of Samples <<----------*/
    srv.on(["sba_action_critical", "sba_action_text", "sba_action_complex", "sba_action_other", "sba_action_valuehelp"], async (req) => {
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.data:`, req.data);
        req.notify(`${req.event} \n\n action triggered with context: \n\n ${JSON.stringify(req.params)} \n\n data: ${JSON.stringify(req.data)}`);
    });

    /*---------->> Handlers for Bound Table Acions <<----------*/
    srv.on(["ta_lr_toolbarAction", "ta_lr_inlineAction", "ta_lr_inlineIconAction"], async (req) => {
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
        req.notify(`${req.event} \n\n action triggered with context: \n\n ${JSON.stringify(req.params)}`);
    });

    srv.on(["ta_op_item_toolbar", "ta_op_item_inline", "ta_op_item_inline2"], async (req) => {
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
        req.notify(`${req.event} \n\n action triggered with context: \n\n ${JSON.stringify(req.params)}`);
    });

    /*---------->> Handlers for FieldGroup Acions <<----------*/
    srv.on(["fg_op_triggerAction", "fg_op_triggerInlineAction01", "fg_op_triggerInlineAction02"], async (req) => {
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
        req.notify(`${req.event} \n\n inline action triggered with context: \n\n ${JSON.stringify(req.params)}`);
    });

    /*---------->> Handlers for Determining Acions <<----------*/
    srv.on(["da_op_clearParymentAction"], async (req) => {
        console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
        req.error(`${req.event} \n\n inline action triggered with context: \n\n ${JSON.stringify(req.params)}`);
    });

    srv.on(["getDefaults"], async (req) => {
      console.log(`🚀 [file: service.js] [${req.event}] ~ req.params:`, req.params);
      return {text1: 'default text 01', text2: 'default text 02'};
    });
});
