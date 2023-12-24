using cap_fe_lr_table_views_service as service from '../../srv/service';

annotate service.Orders with @(
    UI.LineItem #SOTable                         : [
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
            Label: 'Total Amount',
            Value: totalamount,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Customer',
            Value: customer_ID,
        },
    ],
    Analytics.AggregatedProperty #totalamount_sum: {
        $Type               : 'Analytics.AggregatedPropertyType',
        Name                : 'totalamount_sum',
        AggregatableProperty: totalamount,
        AggregationMethod   : 'sum',
        ![@Common.Label]    : 'totalamount (Sum)',
    },
    UI.Chart #ROChart                            : {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Return Orders by Customers',
        ChartType          : #Bar,
        Dimensions         : [customer_ID, ],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: customer_ID,
            Role     : #Category
        }],
        DynamicMeasures    : ['@Analytics.AggregatedProperty#totalamount_sum', ]
    },
    UI.SelectionPresentationVariant #SPVSOTable  : {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Sales Orders (Table)',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Sales Orders (Table)',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type_ID,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #NE,
                    Low   : 'RO',
                }, ],
            }, ],
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#SOTable', ],
        },
    },
    UI.SelectionPresentationVariant #SPVROChart  : {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Return Orders (Chart)',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Sales Orders (Table)',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type_ID,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #EQ,
                    Low   : 'RO',
                }, ],
            }, ],
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.Chart#ROChart', ],
        },
    }
);
