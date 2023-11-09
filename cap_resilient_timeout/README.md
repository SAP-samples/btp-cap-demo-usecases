## Introduction

This repository is an showcase for resilience pattern called timeouts within the context of developing applications on BTP using the Cloud Application Programming Model (CAP). For more info please visit the following blog.

[#SAPCAP: Resilience Pattern – Timeouts using CDS Middleware and Plugin Approach](https://blogs.sap.com/2023/11/09/sapcap-resilience-pattern-timeouts-using-cds-middleware-and-plugin-approach/)


## Getting Started

File or Folder | Purpose
---------|----------
`app/` | It contains app router.
`srv/` | Services are defined in service.cds
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Local Run and Testing

- Open cap_resilient_terminal folder in a new terminal and run `cds watch` to start the cap application. 
- Open cap_resilient_terminal/app/router folder in terminal and run PORT=4005 npm run start to start the router.


## Learn More / Resources

Learn more at https://cap.cloud.sap/docs/get-started/.
