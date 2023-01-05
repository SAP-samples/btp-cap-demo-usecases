namespace cap.fe.se.ca.de.db;

using {
    managed,
    cuid,
    Currency
} from '@sap/cds/common';

entity Industries {
    key id    : String(30);
        descr : String(100);
}

entity Customers : cuid, managed {
    firstname : String(50);
    lastname  : String(50);
    industry  : Association to one Industries;
    addresses : Composition of many Addresses
                    on addresses.customer = $self;
}

entity Addresses : cuid, managed {
    customer : Association to Customers;
    country  : String(30);
    state    : String(30);
    city     : String(30);
    address1 : String(100);
    zipcode  : String(10);
    default  : Boolean;
}

entity Products : managed {
    key id       : String(50);
        text     : String(200);
        category : String(50);
        price    : Decimal;
        currency : Currency;
}

entity Orders : cuid, managed {
    descr     : String(100);
    customer  : Association to one Customers;
    address   : String(500);
    totamount : Decimal;
    currency  : Currency;
    items: Composition of many OrderItems on items.order = $self;
    status: String(20);
}

entity OrderItems : cuid, managed {
    order: Association to Orders;
    product  : Association to one Products;
    quantity : Integer;
    price    : Decimal;
    netprice : Decimal;
    currency : Currency;
}
