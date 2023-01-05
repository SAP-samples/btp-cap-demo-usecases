using orderservice as service from '../../srv/service';
annotate service.Orders @(Common : {
    SideEffects #CustomerChanged : {
        SourceProperties : ['customer_ID'],
        TargetEntities   : [customer, customer.addresses]
    }
});

annotate service.Orders @(Common : {
    SideEffects #ItemChanged     : {
        SourceEntities   : [items],
        TargetProperties : ['totamount', 'currency_code']
    }
});

annotate service.OrderItems @(Common : {
    SideEffects #ProductChanged  : {
        SourceProperties : ['product_id'],
        TargetProperties : ['price', 'currency_code', 'netprice']
    }
});

annotate service.OrderItems @(Common : {
    SideEffects #QuantityChanged : {
        SourceProperties : ['quantity'],
        TargetProperties : ['netprice']
    }
});
