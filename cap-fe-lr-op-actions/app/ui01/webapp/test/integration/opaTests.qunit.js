sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'cap/fe/lr/op/actions/ui01/test/integration/FirstJourney',
		'cap/fe/lr/op/actions/ui01/test/integration/pages/RootsList',
		'cap/fe/lr/op/actions/ui01/test/integration/pages/RootsObjectPage'
    ],
    function(JourneyRunner, opaJourney, RootsList, RootsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('cap/fe/lr/op/actions/ui01') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRootsList: RootsList,
					onTheRootsObjectPage: RootsObjectPage
                }
            },
            opaJourney.run
        );
    }
);