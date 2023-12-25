using cap_fe_lr_table_views_service as service from '../../srv/service';

annotate service.Orders with @(
    UI.LineItem #ROrders                        : [
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
            Value: customer_ID,
        },
    ],
    UI.LineItem #SOrders                        : [
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
            Value: customer.ID,
        },
    ],
    UI.SelectionPresentationVariant #SelPreVarRO: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Return Orders',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Return Orders',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type.ID,
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
            Visualizations: ['@UI.LineItem#ROrders', ],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : ID,
                Descending: false,
            }, ],
            GroupBy       : [customer_ID],
        },
    },
    UI.SelectionPresentationVariant #SelPreVarSO: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Sales Orders',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Return Orders',
            SelectOptions: [{
                $Type       : 'UI.SelectOptionType',
                PropertyName: type.ID,
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
            Visualizations: ['@UI.LineItem#SOrders', ],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : totalamount,
                Descending: false,
            }, ],
            GroupBy       : [type_ID]
        },
    }
);

annotate service.Orders with {
    type @Common.Label: 'Order Type'
};

annotate service.Orders with {
    customer @Common.Label: 'Customer'
};
