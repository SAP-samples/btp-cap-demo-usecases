using {cap.fe.lr.table.views.db as my} from '../db/schema';

@path: '/service/cap_fe_lr_table_views'
service cap_fe_lr_table_views_service {

    entity Orders         as
        projection on my.Orders {
            *,
            type : redirected to OrderTypes
        };

    entity OrderItems     as projection on my.OrderItems;
    entity OrderTypes     as projection on my.OrderTypes;
    entity Customers      as projection on my.Customers;
    entity Products as projection on my.Products;

    @cds.redirection.target: false
    entity ItemTotals     as
        projection on my.OrderItems {
            product.ID,
            product.name,
            sum(order.totalamount) as orderamount : Decimal(10, 2)
        }
        group by product.ID, product.name;

    @cds.redirection.target: false
    entity CustomerTotals as
        projection on my.Orders {
            customer.ID,
            customer.name,
            sum(totalamount) as amount : Decimal(10, 2)
        }
        group by customer.ID, customer.name;
}
