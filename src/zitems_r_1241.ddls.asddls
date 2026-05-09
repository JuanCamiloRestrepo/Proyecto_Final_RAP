@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZITEMS_R_1241
  as select from zitems_1241
  
  association to parent ZSALES_R_1241 as _Sales on $projection.SalesUUID = _Sales.SalesUUID 
  association [0..1] to I_UnitOfMeasure as _UOM on $projection.UOM = _UOM.UnitOfMeasure
  association [0..1] to I_Currency as _Currency on $projection.Currency = _Currency.Currency
  
{
  key item_uuid        as ItemUUID,
      item_id          as ItemID,
      parent_uuid      as SalesUUID,
      name             as Name,
      description      as Description,
      releasedate      as ReleaseDate,
      discontinueddate as DiscontinuedDate,
      @Semantics.amount.currencyCode: 'Currency'
      price            as Price,
      currency         as Currency,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      height           as Height,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      width            as Width,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      depth            as Depth,
      quantity         as Quantity,
      unitofmeasure    as UOM,
      
      // Local ETag Field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      
      _Sales,
      _UOM,
      _Currency
}
