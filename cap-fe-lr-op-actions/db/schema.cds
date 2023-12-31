namespace cap.fe.lr.op.actions.db;

entity Roots {
  key id          : Int16;
      name        : String;
      descr       : String;
      totalAmount : Integer64;
      items       : Composition of many Items
                      on items.root = $self;
      enableUpdation: Boolean;
      disableUpdation: Boolean;
      enableDeletion: Boolean;
      disableDeletion: Boolean
}

entity Items {
  key id         : Int16;
      iname      : String;
      idescr     : String;
      itemAmount : Integer64;
      enableItem : Boolean;
      root       : Association to one Roots;
}

entity Categories {
  key id    : String(10);
      descr : String(100);
}

entity Criticalities {
  key id    : String(10);
      descr : String(100);
}

entity Samples {
  key id     : Int16;
      name   : String;
      descr  : String;
      amount : Integer64;
}
