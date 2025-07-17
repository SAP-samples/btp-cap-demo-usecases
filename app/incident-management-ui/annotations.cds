using IncidentService as service from '../../srv/service';

annotate service.Incidents with @(
    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Incident',
        TypeNamePlural : 'Incidents',
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : status.name,
        },
    },
    UI.SelectionFields : [
        priority_ID,
        status_ID,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : priority.name,
            Criticality : priority.code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status.name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Created At',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Modified At',
            Value : modifiedAt,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'IncidentDetails',
            Label : 'Incident Details',
            Target : '@UI.FieldGroup#IncidentDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Comments',
            Label : 'Comments',
            Target : 'comments/@UI.LineItem',
        },
    ],
    UI.FieldGroup #IncidentDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Priority',
                Value : priority_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Created At',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Created By',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Modified At',
                Value : modifiedAt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Modified By',
                Value : modifiedBy,
            },
        ],
    },
);

annotate service.Comments with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Comment',
            Value : text,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Created At',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Created By',
            Value : createdBy,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CommentDetails',
            Label : 'Comment Details',
            Target : '@UI.FieldGroup#CommentDetails',
        },
    ],
    UI.FieldGroup #CommentDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Comment Text',
                Value : text,
            },
        ],
    },
);

annotate service.Incidents with {
    priority @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Priorities',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : priority_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : priority.name,
        Common.TextArrangement : #TextOnly,
    )
};

annotate service.Incidents with {
    status @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Statuses',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : status.name,
        Common.TextArrangement : #TextOnly,
    )
};

// Field labels and additional annotations
annotate service.Incidents with {
    title @Common.Label : 'Title';
    description @Common.Label : 'Description';
    createdAt @Common.Label : 'Created At';
    createdBy @Common.Label : 'Created By';
    modifiedAt @Common.Label : 'Modified At';
    modifiedBy @Common.Label : 'Modified By';
};

annotate service.Comments with {
    text @Common.Label : 'Comment';
    createdAt @Common.Label : 'Created At';
    createdBy @Common.Label : 'Created By';
};

annotate service.Priorities with {
    name @Common.Label : 'Priority';
    code @Common.Label : 'Code';
    description @Common.Label : 'Description';
};

annotate service.Statuses with {
    name @Common.Label : 'Status';
    code @Common.Label : 'Code';
    description @Common.Label : 'Description';
};
