using cap_fe_lr_op_actions_service as service from '../../../srv/service';

annotate service.Roots with @(UI.FieldGroup #Details: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Value: id,
            Label: 'id',
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'name',
        },
        /*---------->>[ FieldGroup Actions ]<<----------*/
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'cap_fe_lr_op_actions_service.EntityContainer/fg_op_ub_triggerRefresh',
            Label : '(Unbound) Section Trigger'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'cap_fe_lr_op_actions_service.fg_op_triggerInlineAction01',
            Label : 'Inline Trigger 01',
            Inline: true
        }
        /*----------------------------------------------*/
    ]
});

annotate service.Roots with @(UI.FieldGroup #MoreDetails: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Value: descr,
            Label: 'descr',
        },
        {
            $Type: 'UI.DataField',
            Value: totalAmount,
            Label: 'totalAmount',
        },
        /*---------->>[ FieldGroup Actions ]<<----------*/
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'cap_fe_lr_op_actions_service.fg_op_triggerAction',
            Label : 'Section Trigger'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'cap_fe_lr_op_actions_service.fg_op_triggerInlineAction02',
            Label : 'Inline Trigger 02',
            Inline: true
        }
        /*----------------------------------------------*/
    ]
});
