sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'cap/fe/lr/table/views/ui03/test/integration/FirstJourney',
		'cap/fe/lr/table/views/ui03/test/integration/pages/OrdersList',
		'cap/fe/lr/table/views/ui03/test/integration/pages/OrdersObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('cap/fe/lr/table/views/ui03') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage
                }
            },
            opaJourney.run
        );
    }
);