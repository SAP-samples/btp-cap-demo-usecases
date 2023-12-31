using {cap.fe.lr.op.actions.db as db} from '../db/schema';

@path: '/service/cap_fe_lr_op_actions'
service cap_fe_lr_op_actions_service {

  entity Roots      as projection on db.Roots actions {

    //OP Actions
    action ga_op_calculate();

    //Table Actions
    action ta_lr_toolbarAction();
    action ta_lr_inlineAction();
    action ta_lr_inlineIconAction();

    //Field Group Actions
    action fg_op_triggerAction();
    action fg_op_triggerInlineAction01();
    action fg_op_triggerInlineAction02();

    //Determining Action
    action da_op_clearParymentAction();

  };
  entity Items      as projection on db.Items actions {
    action ta_op_item_toolbar();
    action ta_op_item_inline();
    action ta_op_item_inline2();
  };
  entity Categories as projection on db.Categories;
  entity Criticalities as projection on db.Criticalities;


  type inText   : {
    comment: String;
  };
  type inComplexObject : {
    comment : String(50);
    date    : Date;
    datetime: DateTime;
    confirm : Boolean;
    value   : Integer;
  };
  type inOtherObject: {
    input1  :String(50);
    input2  :String(50);
    input3  :String(50);
  };

  type inObject :{
    category    : String;
    criticality : String;
  }

  type inObjectFn:{
    text1: String;
    text2: String;
  }
  
  
  
  entity Samples    as projection on db.Samples actions {
    //Variety of Actions
    /*
      Critical Action
      Action with Text Input
      Action with Multiple Input
      Action with Mandatory and Default Input
      Action with Value Help Input
    */
    action sba_action_critical();
    action sba_action_text(text:inText:comment);
    action sba_action_complex(aprcomment  :inComplexObject:comment,
                              aprdate     :inComplexObject:date,
                              aprdatetime :inComplexObject:datetime,
                              aprconfirm  :inComplexObject:confirm);
    
    @cds.odata.bindingparameter.name : '_it'
    action sba_action_other(text1 :inOtherObject:input1, 
                            @UI.ParameterDefaultValue:'default text'
                            text2 :inOtherObject:input2,
                            @UI.ParameterDefaultValue: _it.name
                            text3 :inOtherObject:input3);
    action sba_action_valuehelp(category:inObject:category,
                                criticality:inObject:criticality);

    @Common.DefaultValuesFunction: 'cap_fe_lr_op_actions_service.getDefaults'
    action sba_action_defaultfn(text1:inObjectFn:text1, 
                                @UI.ParameterDefaultValue: 'default value'
                                text2: inObjectFn:text2);
    function getDefaults() returns inObjectFn;

  };

  //Unbound Actions
  action ga_op_ub_replication();
  action ta_lr_ub_toolbarAction();
  action fg_op_ub_triggerRefresh();
  action ca_op_ub_chartAction();
  action da_op_ub_clearOutstanding();
  
  action sua_action_critical();

  action msg_trigger();


}
