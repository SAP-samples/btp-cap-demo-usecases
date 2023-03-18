using AdminService as service from '../../srv/admin-service';
using from '@sap/cds/common';

annotate service.Customers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : firstName,
            Label : 'First Name',
        },
        {
            $Type : 'UI.DataField',
            Value : lastName,
            Label : 'Last Name',
        },
        {
            $Type : 'UI.DataField',
            Value : creditCardNo,
            Label : 'Credit Card No',
        },
        {
            $Type : 'UI.DataField',
            Value : dateOfBirth,
            Label : 'Date of Birth',
        },
    ]
);
annotate service.Customers with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : firstName,
                Label : 'First Name',
            },
            {
                $Type : 'UI.DataField',
                Value : lastName,
                Label : 'Last Name',
            },
            {
                $Type : 'UI.DataField',
                Value : dateOfBirth,
                Label : 'Date of Birth',
            },
            {
                $Type : 'UI.DataField',
                Value : creditCardNo,
                Label : 'Credit Card No',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Customer Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Email Address',
            ID : 'EmailAddress',
            Target : 'emails/@UI.LineItem#EmailAddress',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Post Addresses',
            ID : 'Addresses',
            Target : 'addresses/@UI.LineItem#Addresses',
        },
    ]
);
annotate service.Customers with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : ID,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
annotate service.Addresses with @(
    UI.LineItem #Addresses : [
        {
            $Type : 'UI.DataField',
            Value : type_id,
            Label : 'Type',
        },
        {
            $Type : 'UI.DataField',
            Value : country_code,
        },{
            $Type : 'UI.DataField',
            Value : state,
            Label : 'State',
        },{
            $Type : 'UI.DataField',
            Value : town,
            Label : 'Town',
        },{
            $Type : 'UI.DataField',
            Value : street,
            Label : 'Street',
        },{
            $Type : 'UI.DataField',
            Value : someOtherField,
            Label : 'Details',
        },]
);
annotate service.Addresses with {
    country @Common.Text : {
            $value : country.name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Customers with {
    email @Common.FieldControl : #Mandatory
};
annotate service.Customers with {
    dateOfBirth @Common.FieldControl : #Mandatory
};
annotate service.Customers with {
    firstName @Common.FieldControl : #Mandatory
};
// annotate service.Addresses with {
//     type @Common.Text : {
//             $value : type.name,
//             ![@UI.TextArrangement] : #TextOnly,
//         }
// };

annotate service.Addresses with {
    type @(Common : {
        Text            : type.name,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Address Types',
            CollectionPath : 'AddressTypes',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'id',
                    LocalDataProperty : 'type_id'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
            ]
        },
        ValueListWithFixedValues: true,
    });
};

annotate service.EmailAddresses with {
    emailType @(Common : {
        Text            : emailType.name,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : 'Email Types',
            CollectionPath : 'EmailTypes',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'id',
                    LocalDataProperty : 'emailType_id'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
            ]
        },
        ValueListWithFixedValues: true,
    });
};

annotate service.EmailAddresses with @(
    UI.LineItem #EmailAddress : [
        {
            $Type : 'UI.DataField',
            Value : emailType_id,
            Label : 'Type',
        },{
            $Type : 'UI.DataField',
            Value : emailAddress,
            Label : 'Email Address',
        },]
);
// annotate service.EmailAddresses with {
//     emailType @Common.Text : {
//             $value : emailType.name,
//             ![@UI.TextArrangement] : #TextOnly,
//         }
// };
