using cap_fe_lr_op_actions_service as service from '../../../srv/service';
// using from './annotations';

annotate service.Roots with @(UI.Identification: [

/*---------->>[ Global Actions ]<<----------*/
    {
        $Type      : 'UI.DataFieldForAction',
        Action     : 'cap_fe_lr_op_actions_service.ga_op_calculate',
        Label      : 'Trigger Calculation',
        Criticality: #Negative
    },
    {
        $Type      : 'UI.DataFieldForAction',
        Action     : 'cap_fe_lr_op_actions_service.EntityContainer/ga_op_ub_replication',
        Label      : '(Unbound) Trigger Replication',
        Criticality: #Positive
    },
    {
        $Type      : 'UI.DataFieldForAction',
        Action     : 'cap_fe_lr_op_actions_service.EntityContainer/msg_trigger',
        Label      : 'Trigger Messages',
        Criticality: #Positive
    },
/*-------------------------------------------*/
/*-------->>[ Determining Actions ]<<--------*/
    {
        $Type      : 'UI.DataFieldForAction',
        Action     : 'cap_fe_lr_op_actions_service.da_op_clearParymentAction',
        Label      : 'Clear Payment Action',
        Determining: true,
        Criticality: #Negative
    },
    {
        $Type      : 'UI.DataFieldForAction',
        Action     : 'cap_fe_lr_op_actions_service.EntityContainer/da_op_ub_clearOutstanding',
        Label      : '(Unbound) Clear Outstanding',
        Determining: true,
        Criticality: #Positive
    }
/*-------------------------------------------*/

]);

