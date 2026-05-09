@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'SalesUUID' ]
define root view entity ZSALES_C_1241
  provider contract transactional_query
  as projection on ZSALES_R_1241
{
  key SalesUUID,
      SalesID,
  
      @Search.defaultSearchElement: true
      Email,
      
      @Search.defaultSearchElement: true
      FirstName,
      
      @Search.defaultSearchElement: true
      LastName,
      
      @Search.defaultSearchElement: true
      Country,
      
      CreatedOn,
      DeliveryDate,
      OrderStatus,
      ImageUrl,
      
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      
      /* Associations */
      _Items : redirected to composition child ZITEMS_C_1241
}
