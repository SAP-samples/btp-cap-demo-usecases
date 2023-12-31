sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'cap.fe.lr.op.actions.ui01',
            componentId: 'RootsList',
            entitySet: 'Roots'
        },
        CustomPageDefinitions
    );
});