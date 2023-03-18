using {sap.cap.dpp as db} from '../db/schema';

service PdmService {
    entity Customers               as projection on db.Customers;    
    entity CustomerPostalAddresses as
        select from db.Addresses {
            *,
            type.name as addressType                };
    entity CustomerEmailAddresses  as
        select from db.EmailAddresses {
            *,
            emailType.name as emailAddressType      };
    entity OrderItemView           as
        select from db.Orders {
            key items.ID         as Item_ID,
                ID               as Order_ID,
                orderNo          as Order_No,
                personalComment  as personalComment,
                customer.ID      as Customer_ID,
                customer.email   as Customer_Email,
                items.game.title as Item_Game,
                items.quantity   as Item_Quantity,
                items.netprice   as Item_NetPrice   };
}