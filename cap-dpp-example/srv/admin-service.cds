using {sap.cap.dpp as db} from '../db/schema';

service AdminService {
    entity Games          as projection on db.Games;
    entity Customers      as projection on db.Customers;
    entity Addresses      as projection on db.Addresses;
    entity EmailAddresses as projection on db.EmailAddresses;
    entity AddressTypes   as projection on db.AddressTypes;
    entity EmailTypes     as projection on db.EmailTypes;
}
