using { cuid, managed } from '@sap/cds/common';

namespace incident.management;

entity Incidents : cuid, managed {
  title       : String(100) @mandatory;
  description : String(500);
  priority    : Association to Priorities;
  status      : Association to Statuses;
  comments    : Composition of many Comments on comments.incident = $self;
}

entity Comments : cuid, managed {
  incident : Association to Incidents;
  text     : String(1000) @mandatory;
}

entity Priorities : cuid {
  code        : String(10) @mandatory;
  name        : String(50) @mandatory;
  description : String(200);
}

entity Statuses : cuid {
  code        : String(20) @mandatory;
  name        : String(50) @mandatory;
  description : String(200);
}
