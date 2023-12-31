using cap_fe_lr_op_actions_service as service from '../../../srv/service';

annotate service.sua_action_critical with @Common.IsActionCritical;
annotate service.Samples actions {
  sba_action_critical @Common.IsActionCritical;
};

annotate service.inText:comment with @Common.Label : 'MultiLine Input Text';
annotate service.inText:comment with @UI.MultiLineText: true;

annotate service.inComplexObject {
  comment   @Common.Label: 'Comment';
  date      @Common.Label: 'Date of Approval';
  datetime  @Common.Label: 'Time of Processing';
  confirm   @Common.Label: 'Confirmation';
};

annotate service.inOtherObject {
  input1  @Common.Label: 'First Input' @mandatory;
  input2  @Common.Label: 'Second Input';
  input3  @Common.Label: 'Third Input'
};

annotate service.inObjectFn {
  text1 @Common.Label: 'First Text Input';
  text2 @Common.Label: 'Second Text Input';
}


annotate service.inObject {
  category @(
    Common.Label: 'Sample Category',
    Common.ValueList : {
      $Type : 'Common.ValueListType',
      CollectionPath : 'Categories',
      Parameters : [
        {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : category,
            ValueListProperty : 'id',
        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'descr',
        }
      ],
      Label : 'Choose One Category'
    },
    Common.ValueListWithFixedValues : false
  );
  criticality @(
    Common.Label: 'Sample Criticality',
    Common.ValueList : {
      $Type : 'Common.ValueListType',
      CollectionPath : 'Criticalities',
      Parameters : [
        {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : criticality,
            ValueListProperty : 'id',
        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'descr',
        }
      ],
      Label : 'Choose One Criticality'
    },
    Common.ValueListWithFixedValues : true
  );
};

annotate service.Samples with @(UI.LineItem #Samples: [
  {
    $Type: 'UI.DataField',
    Label: 'Id',
    Value: id,
  },
  {
    $Type: 'UI.DataField',
    Label: 'Name',
    Value: name,
  },
  {
    $Type: 'UI.DataField',
    Label: 'Description',
    Value: descr,
  },
  {
    $Type: 'UI.DataField',
    Label: 'Amount',
    Value: amount,
  },
  /*---------->>[ Table Actions ]<<----------*/
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.EntityContainer/sua_action_critical',
    Label : '(Unbound) Critical'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_critical',
    Label : 'Critical'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_text',
    Label : 'With Text Input'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_complex',
    Label : 'With Complex Input'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_other',
    Label : 'With Other Input'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_valuehelp',
    Label : 'With Value Help'
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.sba_action_defaultfn',
    Label : 'With Default Function'
  }
/*-------------------------------------------*/
]);
