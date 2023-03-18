using CatalogService as service from '../../srv/catalog-service';

annotate service.Orders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Order No',
            Value : orderNo,
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
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Information',
            Value : personalComment,
        },
    ]
);
annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Order No',
                Value : orderNo,
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Label : 'Information',
                Value : personalComment,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Total Amount',
                Value : totamount,
                ![@Common.FieldControl] : #ReadOnly
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
                ![@Common.FieldControl] : #ReadOnly
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
                Criticality               : {$edmJson : {$If : [{$Eq : [{$Path : 'status'},'Open']},1,3]}},
                CriticalityRepresentation : #WithoutIcon
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            ID : 'Items',
            Target : 'items/@UI.LineItem#Items',
        },
    ]
);
annotate service.Orders with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : ID,
        },
        TypeName : 'Order',
        TypeNamePlural : 'Orders',
    }
);
annotate service.OrderItems with @(
    UI.LineItem #Items : [
        {
            $Type : 'UI.DataField',
            Value : game_ID,
            Label : 'Game',
        },{
            $Type : 'UI.DataField',
            Value : price,
            Label : 'Price',
            ![@Common.FieldControl] : #ReadOnly
        },{
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'Quantity',
        },{
            $Type : 'UI.DataField',
            Value : netprice,
            Label : 'Net Price',
            ![@Common.FieldControl] : #ReadOnly
        },{
            $Type : 'UI.DataField',
            Value : currency_code,
        },]
);
annotate service.OrderItems with {
    game @Common.Text : {
            $value : game.title,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Orders with {
    customer @Common.Text : {
            $value : customer.firstName,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Orders with {
    customer @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'lastName',
                }
            ],
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.Customers with {
    ID @Common.Text : {
        $value : firstName,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.OrderItems with {
    game @(
        Common.ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'Games',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : game_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'title',
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'publisher',
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
