sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'cap/fe/lr/table/views/ui02/test/integration/FirstJourney',
		'cap/fe/lr/table/views/ui02/test/integration/pages/OrdersList',
		'cap/fe/lr/table/views/ui02/test/integration/pages/OrdersObjectPage',
		'cap/fe/lr/table/views/ui02/test/integration/pages/OrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('cap/fe/lr/table/views/ui02') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage,
					onTheOrderItemsObjectPage: OrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);