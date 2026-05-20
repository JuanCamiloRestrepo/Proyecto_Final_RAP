@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSALES_R_1241
  as select from zsalesorder_1241
 
    composition [0..*] of ZITEMS_R_1241 as _Items
    
    association [0..1] to zstatustext_1241 as _SalesDoc on $projection.OrderStatus = _SalesDoc.orderstatus
    association [0..1] to I_Country as _Country on $projection.Country = _Country.Country 

{
  key sales_uuid   as SalesUUID,
      sales_id     as SalesID,
      email        as Email,
      firstname    as FirstName,
      lastname     as LastName,
      country      as Country,
      createdon    as CreatedOn,
      deliverydate as DeliveryDate,
      orderstatus  as OrderStatus,
      imageurl     as ImageUrl,
      
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      // Local ETag Field --> OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      // Total ETag Field
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
     
      _Items,
      _SalesDoc,
      _Country
}
