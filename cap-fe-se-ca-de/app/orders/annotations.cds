using orderservice as service from '../../srv/service';
using from '@sap/cds/common';

annotate service.Orders with @(UI.HeaderInfo : {
    TypeName       : 'Order',
    TypeNamePlural : 'Orders',
    Title          : {
        $Type : 'UI.DataField',
        Value : ID,
    },
});

annotate service.Orders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Order Description',
            Value : descr,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.firstname,
            Label : 'First Name',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.lastname,
            Label : 'Last Name',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Label : 'Total Amount',
            Value : totamount,
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
    ]
);



// annotate service.Orders @(Common : {
//     SideEffects #CustomerChanged : {
//         SourceProperties : ['customer_ID'],
//         TargetProperties : ['address'],
//         TargetEntities   : [
//             customer,
//             customer.addresses
//         ]
//     },
//     SideEffects #ItemChanged     : {
//         SourceEntities   : [items],
//         TargetProperties : [
//             'totamount',
//             'currency_code'
//         ]

//     }
// });


// annotate service.OrderItems @(Common : {
//     SideEffects #ProductChanged  : {
//         SourceProperties : ['product_id'],
//         TargetProperties : [
//             'price',
//             'currency_code',
//             'netprice'
//         ]
//     },
//     SideEffects #QuantityChanged : {
//         SourceProperties : ['quantity'],
//         TargetProperties : ['netprice']
//     }

// });


annotate service.Orders with @(
    // UI.Identification              : [
    //     {
    //         $Type         : 'UI.DataFieldForAction',
    //         Label         : 'Set to In Process',
    //         Action        : 'orderservice.setOrderProcessing',
    //         ![@UI.Hidden] : {$edmJson : {$Ne : [
    //             {$Path : 'status'},
    //             'Open'
    //         ]}}
    //     },
    //     {
    //         $Type         : 'UI.DataFieldForAction',
    //         Label         : 'Set to Open',
    //         Action        : 'orderservice.setOrderOpen',
    //         ![@UI.Hidden] : {$edmJson : {$Eq : [
    //             {$Path : 'status'},
    //             'Open'
    //         ]}}
    //     }
    // ],
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data  : [],
    },
    UI.Facets                      : [
        {
            $Type  : 'UI.CollectionFacet',
            Label  : 'Genral Information',
            ID     : 'GeneralInformation',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    Label  : 'Customer Information',
                    ID     : 'CustomerInfo',
                    Target : '@UI.FieldGroup#CustomerInfo',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    Label  : 'Order Info',
                    ID     : 'OrderInfo',
                    Target : '@UI.FieldGroup#OrderInfo',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    Label  : 'Customer Address',
                    ID     : 'Address',
                    Target : 'customer/addresses/@UI.LineItem#Address',
                },
            ],
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Order Items',
            ID     : 'OrderItems',
            Target : 'items/@UI.LineItem#OrderItems',
        },
    ]
);


annotate service.Addresses with @(Capabilities.SearchRestrictions.Searchable : false);
annotate service.OrderItems with @(Capabilities.SearchRestrictions.Searchable : false);

annotate service.Addresses with @(UI.LineItem #Address : [
    {
        $Type : 'UI.DataField',
        Value : country,
        Label : 'Country',
    },
    {
        $Type : 'UI.DataField',
        Value : state,
        Label : 'State',
    },
    {
        $Type : 'UI.DataField',
        Value : city,
        Label : 'City',
    },
    {
        $Type : 'UI.DataField',
        Value : address1,
        Label : 'Address',
    },
    {
        $Type : 'UI.DataField',
        Value : zipcode,
        Label : 'Zip Code',
    },
    {
        $Type : 'UI.DataField',
        Value : default,
        Label : 'Default',
    }
]);

annotate service.OrderItems with @(UI.LineItem #OrderItems : [
    {
        $Type                 : 'UI.DataField',
        Value                 : ID,
        Label                 : 'ID',
        ![@HTML5.CssDefaults] : {width : '300px'}
    },
    {
        $Type : 'UI.DataField',
        Value : product_id,
        Label : 'Product',
    },
    {
        $Type                   : 'UI.DataField',
        Value                   : price,
        Label                   : 'Price',
        ![@Common.FieldControl] : #ReadOnly
    },
    {
        $Type : 'UI.DataField',
        Value : quantity,
        Label : 'Quantity',
    },
    {
        $Type                   : 'UI.DataField',
        Value                   : netprice,
        Label                   : 'Net Price',
        ![@Common.FieldControl] : #ReadOnly,
    },
    {
        $Type                   : 'UI.DataField',
        Value                   : currency_code,
        ![@Common.FieldControl] : #ReadOnly,
    },
]);

annotate service.OrderItems with {
    currency @Common.Text : currency.descr
};

annotate service.Orders with {
    customer @(
        Common.ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'firstname',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'lastname',
                },
            ],
        },
        Common.ValueListWithFixedValues : false
    )
};

annotate service.OrderItems with {
    product @(
        Common.ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_id,
                    ValueListProperty : 'id',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'text',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'category',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'price',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'currency_code',
                }
            ],
        },
        Common.ValueListWithFixedValues : false
    )
};

annotate service.Orders with {
    customer  @Common.FieldControl  : #Mandatory;
    descr     @Common.FieldControl  : #Mandatory;
    totamount @Measures.ISOCurrency : currency_code;
};

annotate service.Orders with @(UI.FieldGroup #OrderInfo : {
    $Type : 'UI.FieldGroupType',
    Data  : [
        {
            $Type : 'UI.DataField',
            Label : 'Order Description',
            Value : descr,
        },
        {
            $Type                   : 'UI.DataField',
            Label                   : 'Total Amount',
            Value                   : totamount,
            ![@Common.FieldControl] : #ReadOnly
        },
        {
            $Type                     : 'UI.DataField',
            Value                     : status,
            Label                     : 'Order Status',
            Criticality               : {$edmJson : {$If : [{$Eq : [{$Path : 'status'},'Open']},1,3]}},
            CriticalityRepresentation : #WithoutIcon
        },
    ],
});

annotate service.Orders with @(UI.FieldGroup #CustomerInfo : {
    $Type : 'UI.FieldGroupType',
    Data  : [
        {
            $Type : 'UI.DataField',
            Value : customer_ID,
            Label : 'Customer',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.firstname,
            Label : 'First Name',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.lastname,
            Label : 'Last Name',
        },
    ],
});


annotate service.OrderItems with @(UI.LineItem #Address : []);

annotate service.OrderItems with {
    product @Common.Text : product.text
};
