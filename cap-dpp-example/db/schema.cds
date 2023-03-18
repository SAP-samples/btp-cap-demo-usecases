namespace sap.cap.dpp;

using {
    managed,
    Currency,
    Country,
    sap.common.CodeList,
    cuid
} from '@sap/cds/common';


entity Games : cuid, managed {
    title     : String(100);
    descr     : String(300);
    genre     : String(50);
    publisher : String(50);
    stock     : Integer;
    price     : Decimal;
    currency  : Currency;
    image     : String;
}

entity Orders : cuid, managed {
    orderNo         : String;
    items           : Composition of many OrderItems
                          on items.order = $self;
    totamount       : Decimal;
    currency        : Currency;
    customer        : Association to Customers;
    personalComment : String;
    status          : String(20);
}

entity OrderItems : cuid {
    order    : Association to Orders;
    game     : Association to Games;
    quantity : Integer;
    price    : Decimal;
    netprice : Decimal;
    currency : Currency;
}

entity Customers : cuid, managed {
    email        : String;
    firstName    : String;
    lastName     : String;
    creditCardNo : String;
    dateOfBirth  : Date;
    addresses    : Composition of many Addresses
                       on addresses.customer = $self;
    emails       : Composition of many EmailAddresses
                       on emails.customer = $self;
}

entity Addresses : cuid, managed {
    customer       : Association to one Customers;
    type           : Association to one AddressTypes;
    state          : String(128);
    street         : String(128);
    town           : String(128);
    country        : Country;
    someOtherField : String(256);
};

entity EmailAddresses : cuid, managed {
    customer     : Association to one Customers;
    emailType    : Association to one EmailTypes;
    emailAddress : String(200);
}

entity AddressTypes {
    key id   : String(1);
        name : String(30);
}

entity EmailTypes {
    key id   : String(1);
        name : String(30);
}
