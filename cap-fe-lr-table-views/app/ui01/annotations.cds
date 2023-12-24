using cap_fe_lr_table_views_service as service from '../../srv/service';

annotate service.Orders with @(
    UI.SelectionVariant #SelVarRO: {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Return Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type.ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #EQ,
                Low   : 'RO'
            }]
        }]
    },
    UI.SelectionVariant #SelVarSO: {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Sales Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type.ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #NE,
                Low   : 'RO'
            }]
        }]
    }
);


annotate service.Orders with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Label: 'ID',
        Value: ID,
    },
    {
        $Type: 'UI.DataField',
        Label: 'Description',
        Value: descr,
    },
    {
        $Type: 'UI.DataField',
        Label: 'Order Type',
        Value: type.ID,
    },
    {
        $Type: 'UI.DataField',
        Label: 'Total Amount',
        Value: totalamount,
    },
    {
        $Type: 'UI.DataField',
        Label: 'Customer',
        Value: customer.ID,
    },
]);

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ID',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: descr,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Order Type',
                Value: type.ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Total Amount',
                Value: totalamount,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Customer',
                Value: customer.ID,
            },
        ],
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            ID    : 'Items',
            Target: 'items/@UI.LineItem#Items',
        },
    ]
);

annotate service.Orders with @(
    UI.HeaderInfo.TypeName      : 'Order',
    UI.HeaderInfo.TypeNamePlural: 'Orders'
);

annotate service.OrderItems with @(UI.LineItem #Items: [
    {
        $Type: 'UI.DataField',
        Value: ID,
        Label: 'ID',
    },
    {
        $Type: 'UI.DataField',
        Value: product.ID,
        Label: 'Product',
    },
]);

annotate service.OrderItems with {
    product @Common.Text: product.name
};

annotate service.Orders with {
    type     @Common.Text: type.descr;
    customer @Common.Text: customer.name;
};

annotate service.OrderTypes with {
    ID @Common.Text: descr
};

annotate service.Customers with {
    ID @Common.Text: {
            $value : name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};

annotate service.Products with {
    ID @Common.Text: name
};

