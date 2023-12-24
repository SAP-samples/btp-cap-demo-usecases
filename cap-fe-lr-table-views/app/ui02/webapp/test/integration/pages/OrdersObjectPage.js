sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'cap.fe.lr.table.views.ui02',
            componentId: 'OrdersObjectPage',
            entitySet: 'Orders'
        },
        CustomPageDefinitions
    );
});