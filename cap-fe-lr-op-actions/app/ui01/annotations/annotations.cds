using cap_fe_lr_op_actions_service as service from '../../../srv/service';
using from './table-actions';
using from './fieldgroup-actions';
using from './chart-actions';
using from './table-actions';
using from './action-varieties';



annotate service.Roots with @(
    UI.SelectionPresentationVariant #SVPRoots: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Roots',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Empty Selection',
            SelectOptions: []
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#Roots']
        }
    }
);

annotate service.Samples with @( 
    UI.SelectionPresentationVariant #SVPSamples: {
        $Type              : 'UI.SelectionPresentationVariantType',
        Text               : 'Samples',
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            Text         : 'Empty Selection',
            SelectOptions: []
        },
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#Samples']
        }
    }
);


annotate service.Roots with @(UI.Facets: [
    {
        $Type : 'UI.CollectionFacet',
        Label : 'Information',
        ID    : 'Information',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Details',
                ID    : 'Details',
                Target: '@UI.FieldGroup#Details',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'MoreDetails',
                ID    : 'MoreDetails',
                Target: '@UI.FieldGroup#MoreDetails',
            },
        ],
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'Items',
        ID    : 'Items',
        Target: 'items/@UI.LineItem#Items',
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label : 'TotalAmount',
        ID    : 'TotalAmounts',
        Target: 'items/@UI.Chart#ROChart'
    }

]);
