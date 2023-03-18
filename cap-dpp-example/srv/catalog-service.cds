using {sap.cap.dpp as db} from '../db/schema';

service CatalogService {
    entity Games      as projection on db.Games;

    entity Orders     as projection on db.Orders actions {
        @(
            cds.odata.bindingparameter.name: '_it',
            Common.SideEffects             : {TargetProperties: ['_it/status']}
        )
        action setOrderProcessing();
        @(
            cds.odata.bindingparameter.name: '_it',
            Common.SideEffects             : {TargetProperties: ['_it/status']}
        )
        action setOrderOpen();
    };

    function getOrderDefaults() returns Orders;
    entity OrderItems as projection on db.OrderItems;
    entity Customers  as projection on db.Customers;
    entity Addresses  as projection on db.Addresses;
}
