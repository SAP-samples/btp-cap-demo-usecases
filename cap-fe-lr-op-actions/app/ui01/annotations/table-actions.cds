using cap_fe_lr_op_actions_service as service from '../../../srv/service';

annotate service.Roots with @(UI.LineItem#Roots: [
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
    Label: 'Total Amount',
    Value: totalAmount,
  },

  /*---------->>[ Table Actions ]<<----------*/
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.ta_lr_toolbarAction',
    Label : 'Toolbar Action',
  },
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.EntityContainer/ta_lr_ub_toolbarAction',
    Label : '(Unbound) Toolbar Action'
  },
  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'cap_fe_lr_op_actions_service.ta_lr_inlineAction',
    Label      : 'Inline Action',
    Inline     : true,
    Criticality: #Positive,
    ![@UI.Hidden]: disableDeletion
  },
  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'cap_fe_lr_op_actions_service.ta_lr_inlineIconAction',
    Label      : 'Inline Icon Action',
    Inline     : true,
    IconUrl    : 'sap-icon://da',
    Criticality: #Negative
  }
  /*-------------------------------------------*/

]);

annotate service.Items with @(UI.LineItem #Items: [
  {
    $Type: 'UI.DataField',
    Value: id,
    Label: 'Id',
  },
  {
    $Type: 'UI.DataField',
    Value: iname,
    Label: 'Name',
  },
  {
    $Type: 'UI.DataField',
    Value: idescr,
    Label: 'Description',
  },
  {
    $Type: 'UI.DataField',
    Value: itemAmount,
    Label: 'Item Amount',
  },
  /*---------->>[ Table Actions ]<<----------*/
  {
    $Type : 'UI.DataFieldForAction',
    Action: 'cap_fe_lr_op_actions_service.ta_op_item_toolbar',
    Label : 'Item ToolBar Action'
  },
  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'cap_fe_lr_op_actions_service.ta_op_item_inline',
    Label      : 'Item Inline Action',
    Inline     : true,
    Criticality: #Positive,
    ![@UI.Hidden]: {$edmJson: {$Ne: [{$Path: 'enableItem'}, true]}}
  },
  {
    $Type      : 'UI.DataFieldForAction',
    Action     : 'cap_fe_lr_op_actions_service.ta_op_item_inline2',
    Label      : 'Action on Edit',
    Inline     : true,
    Criticality: #Negative,
    ![@UI.Hidden]: IsActiveEntity
  }
  /*-------------------------------------------*/
]);

annotate service.Roots with actions{
  ta_lr_inlineAction      @Core.OperationAvailable: disableUpdation;
  ta_lr_inlineIconAction  @Core.OperationAvailable: {$edmJson: {$Gt: [{$Path: 'totalAmount'}, 1000]}};
  ta_lr_toolbarAction     @Core.OperationAvailable: disableUpdation;
};

