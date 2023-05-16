namespace cap.cql.db;

using {cuid} from '@sap/cds/common';


entity Roots : cuid {
    name    : String(20);
    descr   : String(100);
    dfield  : Date;
    tfield  : Time;
    dtfield : DateTime;
    tsfield : Timestamp;
    nfield  : Integer;
    afield  : Decimal(20, 6);
    asitem  : Association to one AssocSItems;
    amitems : Association to many AssocMItems
                  on amitems.root = $self;
    csitem  : Composition of one CompSItems;
    cmitems : Composition of many CompMItems
                  on cmitems.root = $self;
    category: String(10);
}

entity AssocSItems : cuid {
    asi_sfield : String(20);
    asi_nfield : Integer;
}

entity AssocMItems : cuid {
    asm_sfield : String(20);
    asm_nfield : Integer;
    root       : Association to one Roots;
}

entity CompSItems : cuid {
    csi_sfield : String(20);
    csi_nfield : Integer;
}

entity CompMItems : cuid {
    csm_sfield : String(20);
    csm_nfield : Integer;
    root       : Association to one Roots;
}

entity Roots2 {
    key first  : Integer;
    key second : Integer;
        name   : String(20);
        descr  : String(100);
}
