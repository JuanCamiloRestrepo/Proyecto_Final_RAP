@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'ItemUUID' ]
define view entity ZITEMS_C_1241
  as projection on ZITEMS_R_1241
{
  key ItemUUID,
      ItemID,
  
      SalesUUID,
  
      @Search.defaultSearchElement: true
      Name,
      
      Description,
      ReleaseDate,
      DiscontinuedDate,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH',
                                                     element: 'Currency' },
                                           useForValidation: true }]
      Currency,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      Height,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      Width,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      Depth,
      Quantity,
      
      @ObjectModel.foreignKey.association: '_UOM'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZUOM_LENGTH_1241',
                                                     element: 'uom' },
                                           useForValidation: true }]
      UOM,
      
      LocalLastChangedAt,
      
      /* Associations */
      _Sales : redirected to parent ZSALES_C_1241,
      _UOM,
      _Currency
}
