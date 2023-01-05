using {cap.fe.se.ca.de.db as db} from '../db/schema';

service adminservice @(path : 'service/admin') {

    entity Industries as projection on db.Industries;
    entity Customers  as projection on db.Customers;
    entity Addresses  as projection on db.Addresses;
    entity Products   as projection on db.Products;
    entity Orders     as projection on db.Orders;
    entity OrderItems as projection on db.OrderItems;

}

service orderservice @(path : 'service/order') {
    entity Customers as projection on db.Customers;
    entity Addresses as projection on db.Addresses;
    entity Products  as projection on db.Products;

    entity Orders    as projection on db.Orders actions {

        @(  cds.odata.bindingparameter.name : '_it',
            Common.SideEffects              : {TargetProperties : ['_it/status']}   )
        action setOrderProcessing();

        @(  cds.odata.bindingparameter.name : '_it',
            Common.SideEffects              : {TargetProperties : ['_it/status']}   )
        action setOrderOpen();
        
    };

    function getOrderDefaults() returns Orders;
}
