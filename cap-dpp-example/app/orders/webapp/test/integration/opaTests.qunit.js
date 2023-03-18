sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sap/cap/dpp/ui/orders/test/integration/FirstJourney',
		'sap/cap/dpp/ui/orders/test/integration/pages/OrdersList',
		'sap/cap/dpp/ui/orders/test/integration/pages/OrdersObjectPage',
		'sap/cap/dpp/ui/orders/test/integration/pages/OrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sap/cap/dpp/ui/orders') + '/index.html'
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