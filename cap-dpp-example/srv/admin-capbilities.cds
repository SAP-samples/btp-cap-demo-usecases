using {AdminService as service} from './admin-service';

annotate service with @(
    path    : '/admin',
    requires: ['GameShopAdmin']
);

annotate service.Customers with @(
    assert.integrity   : true,
    odata.draft.enabled: true
);

annotate service.Customers {
    // email         @Communication: {IsEmailAddress}     @mandatory;
    creditCardNo  @assert.format: '^[0-9]{16}$'        @mandatory;
    firstName     @assert.format: '^([a-z]|[A-Z]){1}'  @mandatory;
};

annotate service.Addresses {
    type           @mandatory;
    country_code   @mandatory;
    state          @mandatory;
    someOtherField @mandatory;
};

annotate service.EmailAddresses {
    emailType     @mandatory;
    emailAddress  @Communication: {IsEmailAddress}  @mandatory;
};


annotate service.AddressTypes with @readonly;
