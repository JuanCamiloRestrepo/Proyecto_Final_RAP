@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status - Value Help'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity ZSTATUS_VH_1241 as select from zstatustext_1241
{   
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    key orderstatus as Orderstatus,
    
    @Semantics.text: true
    orderstatustext as Orderstatustext
}
