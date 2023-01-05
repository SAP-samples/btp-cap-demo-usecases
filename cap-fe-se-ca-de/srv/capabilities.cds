using {
    adminservice as admin,
    orderservice as order
} from './service';

annotate admin.Customers with @(odata.draft.enabled : true);
annotate admin.Orders with @(odata.draft.enabled : true);

annotate order.Customers with @(readonly : true);
annotate order.Addresses with @(readonly : true);
annotate order.Orders with @(odata.draft.enabled : true);
