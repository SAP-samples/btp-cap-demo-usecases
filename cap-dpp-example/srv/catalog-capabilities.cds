using { CatalogService as service } from './catalog-service';

annotate service with @(
    path    : '/browse',
    requires: ['GameShopUser']
);

annotate service.Orders with @(
    assert.integrity                : true,
    odata.draft.enabled             : true,
    UI.UpdateHidden                 : {$edmJson : {$Eq : [{$Path : 'status'},'In Process']}},
    Common.DefaultValuesFunction    : 'getOrderDefaults'
);

annotate service.Orders with @(UI.Identification : [
    {
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to In Process',
        Action        : 'CatalogService.setOrderProcessing',
        ![@UI.Hidden] : {$edmJson : {$Ne : [{$Path : 'status'}, 'Open']}}
    },
    {
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to Open',
        Action        : 'CatalogService.setOrderOpen',
        ![@UI.Hidden] : {$edmJson : {$Eq : [{$Path : 'status'},'Open']}}
    }
]);


annotate service.Orders with {
    status @Common.FieldControl : {$edmJson : {$If : [{$Ne : [ {$Path : 'status'}, '' ]}, 1, 3 ]}}
};

annotate service.Orders @(Common : {
    SideEffects #CustomerChanged : {
        SourceProperties : ['customer_ID'],
        TargetEntities   : [customer, customer.addresses]
    },
    SideEffects #ItemChanged : {
        SourceEntities   : [items],
        TargetProperties : ['totamount', 'currency_code']
    }
});


annotate service.OrderItems @(Common : {
    SideEffects #GameChanged  : {
        SourceProperties : ['game_ID'],
        TargetProperties : ['price', 'currency_code', 'netprice']
    },
    SideEffects #QuantityChanged : {
        SourceProperties : ['quantity'],
        TargetProperties : ['netprice']
    }
});
