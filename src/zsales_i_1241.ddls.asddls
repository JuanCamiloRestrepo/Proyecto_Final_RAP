@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSALES_I_1241
    provider contract transactional_interface 
    as projection on ZSALES_R_1241 
{
    key SalesUUID,
    SalesID,
    Email,
    FirstName,
    LastName,
    Country,
    CreatedOn,
    DeliveryDate,
    OrderStatus,
    ImageUrl,    
    
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    
    /* Associations */
    _Items : redirected to composition child ZITEMS_I_1241,
    _SalesDoc,
    _Country
}
