using {cap_fe_lr_table_views_service as service} from './service';

annotate service.Orders with @odata.draft.enabled;
annotate service.OrderTypes with @odata.draft.enabled;
annotate service.Customers with @odata.draft.enabled;
annotate service.ItemTotals with @readonly;
annotate service.CustomerTotals with @readonly;

annotate service.Orders {
    totalamount
    @Aggregation.default: #sum;
}

annotate service.Orders with @Aggregation.ApplySupported: {
    $Type                 : 'Aggregation.ApplySupportedType',
    Transformations       : [
        'aggregate',
        'groupby',
        'filter',
        'search',
        'concat',
        'skip',
        'orderby',
        'top'
    ],
    Rollup                : #None,
    From                  : false,
    GroupableProperties   : [
        ID,
        descr,
        customer_ID,
        type_ID
    ],
    AggregatableProperties: [{
        Property                    : totalamount,
        SupportedAggregationMethods : [
            'sum',
            'max',
            'min',
            'average'
        ],
        RecommendedAggregationMethod: 'sum'
    }]
};

annotate service.CustomerTotals with @Aggregation.ApplySupported: {
    $Type                 : 'Aggregation.ApplySupportedType',
    Transformations       : [
        'aggregate',
        'groupby',
        'filter',
        'search',
        'concat',
        'skip',
        'orderby',
        'top'
    ],
    Rollup                : #None,
    From                  : false,
    GroupableProperties   : [
        ID,
        name
    ],
    AggregatableProperties: [{
        Property                    : amount,
        SupportedAggregationMethods : [
            'sum',
            'max',
            'min'
        ],
        RecommendedAggregationMethod: 'sum'
    }]
};
