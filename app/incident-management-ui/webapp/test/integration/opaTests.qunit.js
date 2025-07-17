sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'incidentmanagementui/test/integration/FirstJourney',
		'incidentmanagementui/test/integration/pages/IncidentsList',
		'incidentmanagementui/test/integration/pages/IncidentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('incidentmanagementui') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);