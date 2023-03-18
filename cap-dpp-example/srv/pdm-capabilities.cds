using {PdmService as service} from './pdm-service';

annotate service with @(
    path    : '/pdm',
    requires: 'PersonalDataManagerUser'
);

// using {sap.cap.dpp as db} from '../db/schema';

annotate service.Customers with {
    email        @Common.Label: 'Email Address';
    firstName    @Common.Label: 'FIrst Name';
    lastName     @Common.Label: 'Last Name';
    creditCardNo @Common.Label: 'Credit Card No';
    dateOfBirth  @Common.Label: 'Date of Birth';
};

annotate service.CustomerPostalAddresses with {
    addressType    @Common.Label: 'Address Type';
    customer       @Common.Label: 'Customer';
    state          @Common.Label: 'State';
    street         @Common.Label: 'Street';
    town           @Common.Label: 'Town';
    country        @Common.Label: 'Country';
    someOtherField @Common.Label: 'Additional Info';
};

annotate service.CustomerEmailAddresses with {
    customer         @Common.Label: 'Customer';
    emailAddressType @Common.Label: 'Email Type';
    emailAddress     @Common.Label: 'Email Address';
};


annotate service.OrderItemView with {
    Order_ID       @Common.Label: 'Order Id';
    Item_ID        @Common.Label: 'Order Item Id';
    Order_No       @Common.Label: 'Order No';
    Customer_ID    @Common.Label: 'Customer Id';
    Customer_Email @Common.Label: 'Email Address';
    Item_Game      @Common.Label: 'Game';
    Item_Quantity  @Common.Label: 'Quantity';
    Item_NetPrice  @Common.Label: 'Net Price';
};


// Personal Data Manager related Annotations
annotate service.Customers with @PersonalData: {
    DataSubjectRole: 'Customer',
    EntitySemantics: 'DataSubject'
};

annotate service.CustomerPostalAddresses with @PersonalData: {
    DataSubjectRole: 'Customer',
    EntitySemantics: 'DataSubjectDetails'
};

annotate service.CustomerEmailAddresses with @PersonalData: {
    DataSubjectRole: 'Customer',
    EntitySemantics: 'DataSubjectDetails'
};

annotate service.OrderItemView with @PersonalData: {EntitySemantics: 'Other'};

annotate service.Customers with {
    ID           @PersonalData.FieldSemantics: 'DataSubjectID';
    email        @PersonalData.IsPotentiallyPersonal  @Communication.IsEmailAddress;
    firstName    @PersonalData.IsPotentiallyPersonal;
    lastName     @PersonalData.IsPotentiallyPersonal;
    creditCardNo @PersonalData.IsPotentiallySensitive;
    dateOfBirth  @PersonalData.IsPotentiallyPersonal;
}

annotate service.CustomerPostalAddresses with {
    customer       @PersonalData.FieldSemantics: 'DataSubjectID';
    addressType    @PersonalData.IsPotentiallyPersonal;
    country        @PersonalData.IsPotentiallyPersonal;
    state          @PersonalData.IsPotentiallyPersonal;
    town           @PersonalData.IsPotentiallyPersonal;
    street         @PersonalData.IsPotentiallyPersonal;
    someOtherField @PersonalData.IsPotentiallyPersonal;
}

annotate service.CustomerEmailAddresses with {
    customer         @PersonalData.FieldSemantics: 'DataSubjectID';
    emailAddressType @PersonalData.IsPotentiallyPersonal;
    emailAddress     @PersonalData.IsPotentiallyPersonal;
};

annotate service.OrderItemView with {
    Item_ID         @PersonalData.FieldSemantics: 'ContractRelatedID';
    Customer_ID     @PersonalData.FieldSemantics: 'DataSubjectID';
    personalComment @PersonalData.IsPotentiallyPersonal;
}

annotate service.Customers with @Communication: {Contact: {
    $Type: 'Communication.ContactType',
    n    : {
        surname: lastName,
        given  : firstName
    },
    bday : dateOfBirth,
    email: [{
        type   : #preferred,
        address: email
    }]
}};

annotate service.CustomerPostalAddresses with @Communication: {Contact: {
    $Type: 'Communication.ContactType',
    adr  : [{
        street : street,
        region : state,
        country: country.name,
        type   : type_id
    }]
}};

annotate service.CustomerEmailAddresses with @Communication: {Contact: {
    $Type: 'Communication.ContactType',
    email: [{
        type   : emailAddressType,
        address: emailAddress
    }]
}, };