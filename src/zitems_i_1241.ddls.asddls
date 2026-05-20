@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZITEMS_I_1241 
    as projection on ZITEMS_R_1241
{
    key ItemUUID,
    ItemID,
    SalesUUID,
    Name,
    Description,
    ReleaseDate,
    DiscontinuedDate,
    Price,
    Currency,
    @Semantics.quantity.unitOfMeasure: 'UOM'
    Height,
    @Semantics.quantity.unitOfMeasure: 'UOM'
    Width,
    @Semantics.quantity.unitOfMeasure: 'UOM'
    Depth,
    Quantity,
    UOM,
    
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChangedAt,
    
    /* Associations */
    _Sales : redirected to parent ZSALES_I_1241,
    _UOM,
    _Currency
}
