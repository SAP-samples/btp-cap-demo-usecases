using adminservice as service from '../../srv/service';

annotate service.Customers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : industry.id,
            Label : 'Industry',
        },
        {
            $Type : 'UI.DataField',
            Label : 'First Name',
            Value : firstname,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Last Name',
            Value : lastname,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt,
        },
    ]
);
annotate service.Customers with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : industry_id,
                Label : 'Industry',
            },
            {
                $Type : 'UI.DataField',
                Label : 'First Name',
                Value : firstname,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Last Name',
                Value : lastname,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Addresses',
            ID : 'Addresses',
            Target : 'addresses/@UI.LineItem#Addresses',
        },
    ]
);
annotate service.Addresses with @(
    UI.LineItem #Addresses : [
        {
            $Type : 'UI.DataField',
            Value : country,
            Label : 'Country',
        },{
            $Type : 'UI.DataField',
            Value : state,
            Label : 'State',
        },{
            $Type : 'UI.DataField',
            Value : city,
            Label : 'City',
        },{
            $Type : 'UI.DataField',
            Value : address1,
            Label : 'Address',
        },{
            $Type : 'UI.DataField',
            Value : zipcode,
            Label : 'Zip Code',
        },{
            $Type : 'UI.DataField',
            Value : default,
            Label : 'Default',
        },]
);
annotate service.Customers with @(
    UI.HeaderInfo : {
        TypeName : 'Customer',
        TypeNamePlural : '',
        Title : {
            $Type : 'UI.DataField',
            Value : ID,
        },
    }
);
annotate service.Industries with {
    id @Common.Text : {
            $value : descr,
            ![@UI.TextArrangement] : #TextLast,
        }
};
annotate service.Industries with {
    id @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Industries',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : id,
                    ValueListProperty : 'id',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Customers with {
    industry @UI.MultiLineText : false
};
annotate service.Customers with {
    industry @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Industries',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : industry_id,
                    ValueListProperty : 'id',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Customers with {
    industry @Common.Text : {
        $value : industry.descr,
        ![@UI.TextArrangement] : #TextLast,
    }
};
