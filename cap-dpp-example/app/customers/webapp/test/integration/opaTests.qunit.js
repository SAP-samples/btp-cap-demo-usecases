sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sap/cap/dpp/app/customers/test/integration/FirstJourney',
		'sap/cap/dpp/app/customers/test/integration/pages/CustomersList',
		'sap/cap/dpp/app/customers/test/integration/pages/CustomersObjectPage',
		'sap/cap/dpp/app/customers/test/integration/pages/AddressesObjectPage'
    ],
    function(JourneyRunner, opaJourney, CustomersList, CustomersObjectPage, AddressesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sap/cap/dpp/app/customers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCustomersList: CustomersList,
					onTheCustomersObjectPage: CustomersObjectPage,
					onTheAddressesObjectPage: AddressesObjectPage
                }
            },
            opaJourney.run
        );
    }
);