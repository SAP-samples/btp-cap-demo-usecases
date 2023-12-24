using cap_fe_lr_table_views_service as service from '../../srv/service';

annotate service.Orders with @(
    UI.LineItem #OrdersList                       : [
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
            Value: type_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Total Amoint',
            Value: totalamount,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Customer',
            Value: customer_ID,
        },
    ],
    UI.SelectionPresentationVariant #SVPOrdersList: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'List Orders',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'List Orders',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: totalamount,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #GT,
                    Low   : '0',
                }, ],
            }, ],
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#OrdersList', ],
        },
    },
    UI.SelectionVariant #SVOLSS                   : {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Standard Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type_ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #EQ,
                Low   : 'SS',
            }]
        }]
    },
    UI.SelectionVariant #SVOLCS                   : {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Cash Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type_ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #EQ,
                Low   : 'CS',
            }]
        }]
    },
    UI.SelectionVariant #SVOLRS                   : {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Rush Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type_ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #EQ,
                Low   : 'RS',
            }]
        }]
    },
    UI.SelectionVariant #SVOLRO                   : {
        $Type        : 'UI.SelectionVariantType',
        Text         : 'Return Orders',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: type_ID,
            Ranges      : [{
                $Type : 'UI.SelectionRangeType',
                Sign  : #I,
                Option: #EQ,
                Low   : 'RO',
            }]
        }]
    }
);

annotate service.CustomerTotals with {
    ID  @Common.Label: 'Customer'  @Common.Text: name
};

annotate service.CustomerTotals with @(
    Analytics.AggregatedProperty #amount_sum          : {
        $Type               : 'Analytics.AggregatedPropertyType',
        Name                : 'amount_sum',
        AggregatableProperty: amount,
        AggregationMethod   : 'sum',
        ![@Common.Label]    : 'Amount (Sum)',
    },
    UI.Chart #CustomerTotalsChart                     : {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Return Orders by Customers',
        ChartType          : #Bar,
        Dimensions         : [ID, ],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: ID,
            Role     : #Category
        }],
        DynamicMeasures    : ['@Analytics.AggregatedProperty#amount_sum', ]
    },
    UI.SelectionPresentationVariant #SVPCustomerTotals: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Totals by Customer',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Totals by Customer',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: amount,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #GT,
                    Low   : '0',
                }, ],
            }, ],
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.Chart#CustomerTotalsChart'],
        },
    }
);


annotate service.ItemTotals with @(
    UI.LineItem #ItemTotals                       : [
        {
            $Type: 'UI.DataField',
            Label: 'ID',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Order Amount      ',
            Value: orderamount,
        }
    ],
    UI.SelectionPresentationVariant #SVPItemTotals: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Totals by Item',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Totals by Item',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: orderamount,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #GT,
                    Low   : '0',
                }, ],
            }, ],
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#ItemTotals', ],
        },
    }
);
