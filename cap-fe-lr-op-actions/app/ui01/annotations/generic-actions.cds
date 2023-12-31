using cap_fe_lr_op_actions_service as service from '../../../srv/service';
/*---------->>[ Generic Actions ]<<----------*/
/*-------------------------------------------*/

/*-----> Create Action

annotate service.Roots with @(
    UI.CreateHidden: true
);

<-----*/

/*-----> Edit Action

annotate service.Roots with @(
    UI.UpdateHidden: true
);

<-----*/

/*-----> Edit Action: By Property and By Dynamic Expression

annotate service.Roots with @(
  UI.UpdateHidden: disableUpdation
);

annotate service.Roots with @(
  UI.UpdateHidden : {$edmJson: {$Ne: [{$Path: 'enableUpdation'}, true]}}
);

<-----*/

/*-----> Delete Action

annotate service.Roots with @(
    UI.DeleteHidden: true
);

<-----*/

/*-----> Delete Action: By Property and By Dynamic Expression

annotate service.Roots with @(
  UI.DeleteHidden: disableDeletion
);

annotate service.Roots with @(
  UI.DeleteHidden : {$edmJson: {$Ne: [{$Path: 'enableDeletion'}, true]}}
);

<-----*/
/*-------------------------------------------*/