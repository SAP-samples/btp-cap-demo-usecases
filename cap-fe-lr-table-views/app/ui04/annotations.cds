using cap_fe_lr_table_views_service as service from '../../srv/service';

annotate service.Orders with @(
    UI.LineItem #SO                       : [
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
    UI.SelectionPresentationVariant #SPVSO: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#SO', ],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : ID,
                Descending: false,
            }, ]
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type_ID,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #NE,
                    Low   : 'RO',
                }, ]
            }]
        },
        Text               : 'Sales Orders'
    },
    UI.LineItem #RO                       : [
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
    UI.SelectionPresentationVariant #SPVRO: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#RO', ],
            GroupBy       : [customer_ID]
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type_ID,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #I,
                    Option: #EQ,
                    Low   : 'RO',
                }, ]
            }]
        },
        Text               : 'Return Orders'
    },
    UI.SelectionVariant #SVSS             : {
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
    UI.SelectionVariant #SVCS             : {
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
    UI.SelectionVariant #SVRS             : {
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
    }
);
