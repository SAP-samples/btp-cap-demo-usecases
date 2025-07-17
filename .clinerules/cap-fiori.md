- for SAP CAP (Cloud Application Programming) applications, refer the @cap docs for better information.
 
Some Additional Information for CAP App
- If you are using cuid aspect, a default coulmn ID is added and usually has UUIDs.

- always use cds init and dont' use "cds init projectname"

- always a nodejs cap based application (don't add --add, just init is fine)

- always add cds lint after genering the application

- Always CAP application should be draft enabled.

- Prefer composition over assocation SAP CAP for child entities.

- cds managed aspect should be used whereever it is neccessary and should be added to entity then only it will work.

- Don't use enums, prefer associated tables and with preload configuraiton data

- To generate a fiori application, following steps are required
    a. First step is to generate a json config file like shown below
```
{
    "version": "0.2",
    "floorplan": "FE_LROP",
    "project": {
        "name": "sales-order-headers-management1",
        "targetFolder": "/home/user/projects/vibecoding",
        "title": "Sales Order Headers",
        "description": "Manage sales order headers efficiently",
        "ui5Version": "1.132.1",
        "localUI5Version": "1.82.2",
        "sapux": true
    },
    "service": {
        "servicePath": "/service/vibecoding/",
        "capService": {
            "projectPath": "/home/user/projects/vibecoding",
            "serviceName": "vibecodingSrv",
            "serviceCdsPath": "srv/service.cds"
        }
    },
    "entityConfig": {
        "mainEntity": {
            "entityName": "SalesOrderHeaders"
        },
        "generateFormAnnotations": true
    },
    "projectType": "FORM_ENTRY_OBJECT_PAGE",
    "telemetryData": {
        "generationSourceName": "AI Headless",
        "generationSourceVersion": "1.18.1"
    }
}
```
    note: use always this version of ui5: "ui5Version": "1.132.1", "localUI5Version": "1.82.2".

    b. run the below command to generate the fiori application -headless way

```
// /home/user/projects/vibecoding/.fiori-ai/generator-config.json is path to the json config file
yo @sap/fiori:headless "/home/user/projects/vibecoding/.fiori-ai/generator-config.json" --force

``` 
    c. add neccessary annotations in teh generated fiori application usually in annotations.cds file. check https://github.com/SAP-samples/fiori-elements-feature-showcase for any guidance. [Tables for compositions, labels for all fields, valuehelps, etc., - ensure the ui is complete]



- "don't add random samples using cds add sample"

- For value helps 

- before testing use cds build to find any annotations errors and fix them, for more details about annotaitons check https://github.com/SAP-samples/fiori-elements-feature-showcase

- for cds views use #TextOnly

- for smaller set of data, prefer fixed values (dropdown) instead of popup help - ValueListWithFixedValues: true

- cds watch to test locally, use browswer testing mcp to confirm if it's working fine and UI looks good.

- always use node module "yo" with version 4.3.1 and before installing check if yo is already there and @sap/generator-fiori -> for fiori app generation.

- after cds watch, don't call `sleep 5 or 3`, it will stop cds watch.

- If cuid is added to entity, then ID will be uuid, so ensure sample data will have ID type uuid.