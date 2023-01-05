using orderservice as service from '../../srv/service';
using from './annotations';

annotate service.Orders with @(
    Common.DefaultValuesFunction : 'getOrderDefaults'
);

annotate service.Orders with @(UI.Identification : [
    {
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to In Process',
        Action        : 'orderservice.setOrderProcessing',
        ![@UI.Hidden] : {$edmJson : {$Ne : [{$Path : 'status'}, 'Open']}}
    },
    {
        $Type         : 'UI.DataFieldForAction',
        Label         : 'Set to Open',
        Action        : 'orderservice.setOrderOpen',
        ![@UI.Hidden] : {$edmJson : {$Eq : [{$Path : 'status'},'Open']}}
    }
]);

annotate service.Orders with @(
    UI.UpdateHidden              : {$edmJson : {$Eq : [{$Path : 'status'},'In Process']}}
);

annotate service.Orders with {
    status @Common.FieldControl : {$edmJson : {$If : [{$Ne : [ {$Path : 'status'}, '' ]}, 1, 3 ]}}
};
