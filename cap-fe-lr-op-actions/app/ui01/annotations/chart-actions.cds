using cap_fe_lr_op_actions_service as service from '../../../srv/service';

annotate service.Items with @(
    Analytics.AggregatedProperty #itemamount_sum: {
        $Type               : 'Analytics.AggregatedPropertyType',
        Name                : 'itemamount_sum',
        AggregatableProperty: itemAmount,
        AggregationMethod   : 'sum',
        ![@Common.Label]    : 'itemamount (Sum)'
    },
    UI.Chart #ROChart                            : {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Amount By Item',
        ChartType          : #Bar,
        Dimensions         : [iname],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: iname,
            Role     : #Category
        }],
        DynamicMeasures    : ['@Analytics.AggregatedProperty#itemamount_sum'],
        Actions : [
            {
                $Type      : 'UI.DataFieldForAction',
                Action     : 'ca_op_ub_chartAction',
                Label      : '(Unbound) Chart Action',
                Criticality: #Positive
            }
        ]
    },
) ;