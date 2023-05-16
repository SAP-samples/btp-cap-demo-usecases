using {cap.cql.db as db} from '../db/schema';

service CQLService {

    entity Roots       as projection on db.Roots;
    entity AssocSItems as projection on db.AssocSItems;
    entity AssocMItems as projection on db.AssocMItems;
    entity CompSItems  as projection on db.CompSItems;
    entity CompMItems  as projection on db.CompMItems;
    entity Roots2       as projection on db.Roots2;

    function testCQLExamples() returns String(100);

}
