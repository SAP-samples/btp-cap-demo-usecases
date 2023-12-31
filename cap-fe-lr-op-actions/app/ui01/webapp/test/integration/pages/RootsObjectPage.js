sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'cap.fe.lr.op.actions.ui01',
            componentId: 'RootsObjectPage',
            entitySet: 'Roots'
        },
        CustomPageDefinitions
    );
});