using { cap_fe_lr_op_actions_service as service } from './service';

annotate service.Roots with @odata.draft.enabled;
annotate service.Samples with @readonly @Capabilities.SearchRestrictions:{Searchable: false};


annotate service.Items with @Aggregation.ApplySupported: {
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
        id,
        iname,
        idescr
    ],
    AggregatableProperties: [{
        Property                    : itemAmount,
        SupportedAggregationMethods : [
            'sum',
            'max',
            'min',
            'average'
        ],
        RecommendedAggregationMethod: 'sum'
    }]
};

annotate service.Items {
    itemAmount
    @Aggregation.default: #sum;
};

/*---------->>[ Generic Actions ]<<----------*/
/*-------------------------------------------*/

/*-----> Create Action

annotate service.Roots with @(
    Capabilities.Insertable: false
);

<-----*/

/*-----> Edit Action

annotate service.Roots with @(
    Capabilities.Updatable: false
);

<-----*/

/*-----> Delete Action

annotate service.Roots with @(
    Capabilities.Deletable: false
);

<-----*/
