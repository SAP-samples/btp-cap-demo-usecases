using { incident.management as im } from '../db/schema';

service IncidentService @(path: '/service/incident') {
  
  @odata.draft.enabled
  entity Incidents as projection on im.Incidents;
  
  entity Comments as projection on im.Comments;
  
  @readonly
  entity Priorities as projection on im.Priorities;
  
  @readonly
  entity Statuses as projection on im.Statuses;
}
